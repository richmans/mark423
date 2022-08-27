class HostingController < ApplicationController
  def redirect
    podcast = Podcast.find_by(shortname: params[:podcast])
    filename = params[:filename]
    podcast_domain = Rails.application.config.podcast_domain
    
    if file == 'podcast.rss'
      #url = podcast.url
    else
      recording = podcast.recordings.find_by(filename: filename)
      if recording.nil? || ! recording.audio_file.attached? || ! recording.audio_file.analyzed?
        render "Nope", status: :not_found
      end
      url = recording.audio_file.url
    end
    redirect_to url, status: :moved_permanently
  end

  def not_found
    render status: :not_found
  end

end