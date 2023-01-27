class PublicationMailer < ApplicationMailer
  helper :application
  default from: "notifications@mark423.com"
  def recording_published(recording)
    @recording = recording
    User.where(is_admin: true).each do |user|
      mail to: user.email, subject: "Podcast published"
    end
  end
end

