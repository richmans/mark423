require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mark423
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
   
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.

    config.app_url = ENV['APP_URL'] || 'https://mark423.com'
    config.podcast_host = ENV['PODCAST_HOST'] || config.app_url + '/podcasts'
    
    config.active_job.queue_adapter = :delayed_job
    config.time_zone = "Amsterdam"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
