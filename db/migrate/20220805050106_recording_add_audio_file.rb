class RecordingAddAudioFile < ActiveRecord::Migration[7.0]
  def change
    add_column :recordings, :audio_file, :attachment
  end
end
