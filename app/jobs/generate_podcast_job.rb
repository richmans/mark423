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
        return false
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
    begin
      logger.info("Rendering podcast #{podcast.name} version #{version}")
      podcast.skip_callbacks = true
      # Do the work
      rendered_string = RenderController.new.render_to_string(
        template: 'render/show',
        formats: [:js],
        assigns: { podcast: podcast },
        layout: false
      )
      podcast.js_file.attach(
        io: StringIO.new(rendered_string),
        filename: 'podcast.js',
        content_type: 'application/javascript',
        identify: false
      )
      rendered_string = RenderController.new.render_to_string(
        template: 'render/show',
        formats: [:rss],
        assigns: { podcast: podcast },
        layout: false
      )
      podcast.rss_file.attach(
        io: StringIO.new(rendered_string),
        filename: 'podcast.rss',
        content_type: 'application/rss+xml',
        identify: false
      )
    ensure
      unlock_podcast(podcast, version)
    end
  end

end
