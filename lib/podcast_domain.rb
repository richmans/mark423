class PodcastDomain
  def self.matches? request
    
    request.subdomain == Rails.application.config.podcast_host
  end
end