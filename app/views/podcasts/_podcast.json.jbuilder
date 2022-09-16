json.extract! podcast, :id, :name, :category, :website, :shortname, :copyright, :author, :email, :keywords,:description, :created_at, :updated_at
json.url podcast_url(podcast, format: :json)
