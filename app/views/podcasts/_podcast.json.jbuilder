json.extract! podcast, :id, :name, :shortname, :copyright, :author, :email, :keywords, :created_at, :updated_at
json.url podcast_url(podcast, format: :json)
