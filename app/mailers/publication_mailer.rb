class PublicationMailer < ApplicationMailer
  helper :application
  default from: "notifications@mark423.com"
  def recording_published(recording)
    @recording = recording
    emails = User.where(is_admin: true, notifications: true).collect(&:email)
    if emails.any?
      mail to: emails, subject: "Podcast published"
    end
  end
end

