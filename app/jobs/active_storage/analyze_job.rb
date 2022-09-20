class ActiveStorage::AnalyzeJob < ActiveStorage::BaseJob
  def perform(blob)
    blob.analyze
    blob.attachments.includes(:record).each do |attachment|
      if attachment.record_type == 'Podcast'
        attachment.record.touch
      elsif attachment.record_type == 'Recording'
        attachment.record.touch
      end
    end
  end
end