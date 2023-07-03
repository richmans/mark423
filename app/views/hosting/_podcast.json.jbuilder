json.extract! podcast, :id, :shortname, :name, :updated_at
json.url fetch_podcast_url(podcast.shortname, format: :rss)
