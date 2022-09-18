json.extract! recording, :id, :podcast_id, :speaker, :theme, :recorded_at, :published, :visible, :description, :created_at, :updated_at
json.url recording_url(recording, format: :json)
