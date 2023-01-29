#!/usr/bin/env ruby
require 'uri'
require 'open-uri'
require 'net/http'
require './podcast_fetcher.rb'

if ARGV.length != 2
  puts "Usage: ./podcast_backup.rb <podcast url> <backup directory>"
  exit 1
end
puts "== Podcast Back'r-upper =="

url = ARGV[0]
directory = ARGV[1]

def ensure_directory(directory)
  unless Dir.exists?(directory)
    Dir.mkdir(directory)
  end
end

def download_file(directory, file, url)
  fn = File.join(directory, file)
  URI.open(url) do |f|
    IO.copy_stream(f, fn)
  end
end

def main(url, directory)
  rss_file = File.join(directory, 'podcast.rss')
  ensure_directory(directory)
  download_file(directory, 'podcast.rss', url)
  fetcher = PodcastFetcher.new
  xml = File.read(rss_file)
  parsed_podcast = fetcher.parse_xml(xml)
  image_file = File.basename(URI(parsed_podcast.image_url).path)
  download_file(directory, image_file, parsed_podcast.image_url)
end

main(url, directory)
