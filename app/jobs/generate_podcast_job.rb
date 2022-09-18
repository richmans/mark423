class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def lock_podcast(podcast, version)
    start_time = Time.now
    while Time.now - start_time < 30 do
      updated_rows = Podcast.where(id: podcast.id).where('rendered_version < ? and rendering_version = 0', version).update_all(rendering_version: version)
      return true if updated_rows == 1   
      podcast.reload
      break if podcast.rendered_version >= version
      break if podcast.rendering_version >= version
      logger.debug "Waiting for podcast #{podcast.shortname} to become available for render #{version}"
      sleep 1
    end
    return false
  end

  def unlock_podcast(podcast, version)
    podcast.reload
    podcast.update_columns rendered_version: version, rendering_version: 0      
  end

  def perform(podcast, version)
    if not lock_podcast(podcast, version)
      logger.info("Skipping render for #{podcast.name} version #{version}")
      return
    end
    logger.info("Rendering podcast #{podcast.name} version #{version}")
    
    # Do the work
    sleep 3

    unlock_podcast(podcast, version)
  end
end
