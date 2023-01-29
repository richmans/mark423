require 'podcast_fetcher'
require 'podcast_updater'

namespace :mark423 do
  desc 'import a podcast into mark423'
  task :import => :environment do
    if ARGV.length < 2
      puts "Usage: rails mark423:import PODCAST URL"
      exit 1
    end
    podcast_shortname = ARGV[0]
    url = ARGV[1]
    puts "Importing #{url} into #{podcast_shortname}"
    parsed_podcast = PodcastFetcher.new.fetch(url)
    PodcastUpdater.new(podcast_shortname, parsed_podcast).update(parsed_podcast)
    exit 0
  end
end

