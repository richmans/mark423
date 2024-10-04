require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mark423
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
   
    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.

    config.app_url = ENV['APP_URL'] || 'https://mark423.com'
    config.podcast_host = ENV['PODCAST_HOST'] || config.app_url + '/podcasts'
    config.local_storage = "tmp/local"
    config.active_job.queue_adapter = :delayed_job
    config.time_zone = "Amsterdam"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
