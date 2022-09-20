class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def lock_podcast(podcast, version)
    start_time = Time.now
    while Time.now - start_time < 30 do
      updated_rows = Podcast.where(id: podcast.id, rendering: nil, updated_at: version).update_all(rendering: version)
      return true if updated_rows == 1   
      podcast.reload
      if podcast.updated_at > version
        logger.info("Skipping podcast #{podcast.shortname} render #{version} because a newer job is scheduled")
      end
      if !podcast.rendered.nil? &&  podcast.rendered >= version
        logger.info("Skipping podcast #{podcast.shortname} render #{version} because a newer job is rendered")
        return false
      end
      if !podcast.rendering.nil? && podcast.rendering >= version
        logger.info("Skipping podcast #{podcast.shortname} render #{version} because a newer job is rendering")
        return false
      end
      logger.debug "Waiting for podcast #{podcast.shortname} to become available for render #{version}"
      sleep 1
    end
    logger.error("Error waiting for podcast #{podcast.shortname} render #{version}. Job seems stuck")
    return false
  end

  def unlock_podcast(podcast, version)
    podcast.reload
    podcast.update_columns rendering: nil, rendered: version
  end

  def perform(podcast, version)
    return if not lock_podcast(podcast, version)
    logger.info("Rendering podcast #{podcast.name} version #{version}")
    
    # Do the work
    sleep 3

    unlock_podcast(podcast, version)
  end
end
