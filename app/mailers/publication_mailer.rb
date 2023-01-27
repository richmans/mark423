class PublicationMailer < ApplicationMailer
  helper :application
  default from: "notifications@mark423.com"
  layout "mailer"
  def publication(recording)
    puts "YOOOO"
    @recording = recording
    User.where(is_admin: true).each do |user|
      mail to: user.email, subject: "Podcast published"
    end
  end
end

