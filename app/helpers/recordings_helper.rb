module RecordingsHelper
  def recording_duration(recording)
    if recording.audio_file.analyzed?
      return ActiveSupport::Duration.build(recording.audio_file.metadata['duration'].round()).inspect
    else
      return "Unknown"
    end
  end
end
