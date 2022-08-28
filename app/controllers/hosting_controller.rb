class HostingController < ApplicationController
  def nope
    render plain: "nope", status: :not_found
  end

  def fetch_recording
    podcast = Podcast.find_by(shortname: params[:podcast])
    return nope if podcast.nil?
    recording = podcast.recordings.find_by(filename: params[:filename])
    return nope if recording.nil? || ! recording.audio_file.attached? || ! recording.audio_file.analyzed?
    url = recording.audio_file.url
    redirect_to url, status: :found
  end

  def fetch_podcast
    podcast = Podcast.find_by(shortname: params[:podcast])
    return nope if podcast.nil?
    respond_to do |format|
      format.jpeg { redirect_to podcast.image_file.url, status: :found }
      format.rss { redirect_to url_for(podcast.rss_file), status: :found}
    end
  end 

  def not_found
    render status: :not_found
  end

end