#!/usr/bin/env ruby
require 'uri'
require 'open-uri'
require 'net/http'
require './podcast_fetcher.rb'
require 'json'

if ARGV.length != 2
  puts "Usage: ./podcast_backup.rb <url_for_index.js> <root directory>"
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
  puts "Downloading #{url}"
  fn = File.join(directory, file)
  URI.open(url) do |f|
    IO.copy_stream(f, fn)
  end
end

def check_or_download_file(directory, file, url, expected_size)
  fn = File.join(directory, file)
  if File.exists?(fn)
    return if File.size(fn) == expected_size
    puts "Expected #{expected_size} but found #{File.size(fn)}"
  end
  
  download_file(directory, file, url)
end

def backup_podcast(url, directory)
  puts "=== PODCAST #{url} ==="
  rss_file = File.join(directory, 'podcast.rss')
  ensure_directory(directory)
  download_file(directory, 'podcast.rss', url)
  fetcher = PodcastFetcher.new
  xml = File.read(rss_file)
  parsed_podcast = fetcher.parse_xml(xml)
  image_file = File.basename(URI(parsed_podcast.image_url).path)
  download_file(directory, image_file, parsed_podcast.image_url)
  parsed_podcast.items.each do | i |
    audio_file = File.basename(URI(i.audio_url).path)
    check_or_download_file(directory, audio_file, i.audio_url, i.bytes)
  end
end

def main(root_url, root_dir)
  ensure_directory(root_dir)
  data = Net::HTTP.get_response(URI.parse(root_url)).body
  podcasts = JSON.parse(data)
  podcasts.each do |pod|
    pod_dir = File.join(root_dir, pod['shortname'])
    backup_podcast(pod['url'], pod_dir)
  end
end

main(url, directory)
