class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def perform(podcast)
    logger.info("Rendering podcast #{podcast.name}")
  end
end
