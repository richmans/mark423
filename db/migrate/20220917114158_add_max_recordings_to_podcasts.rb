class AddMaxRecordingsToPodcasts < ActiveRecord::Migration[7.0]
  def change
    add_column :podcasts, :max_recordings, :integer, :default => 100
  end
end
