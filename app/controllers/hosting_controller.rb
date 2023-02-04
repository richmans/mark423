class HostingController < ApplicationController
  skip_before_action :verify_authenticity_token
  include ActiveStorage::SetCurrent
  def nope
    render plain: "nope", status: :not_found
  end

  def index
    @podcasts = Podcast.all

    render :json, template: "hosting/index", status: :ok
    
  end

  def fetch_recording
    podcast = Podcast.find_by(shortname: params[:podcast])
    return nope if podcast.nil?
    recording = podcast.recordings.find_by(filename: params[:filename])
    return nope if recording.nil? || ! recording.audio_file.attached? || ! recording.audio_file.analyzed?
    respond_to do |format| 
      format.mp3 { redirect_to  recording.audio_file.url, status: :found, allow_other_host: true}
      format.jpeg { redirect_to  recording.image_file.url, status: :found, allow_other_host: true}
    end
  end

  def player
    redirect_to ActionController::Base.helpers.asset_path("mark423-player")
  end

  def fetch_podcast
    podcast = Podcast.find_by(shortname: params[:podcast])
    return nope if podcast.nil?
    respond_to do |format|
      format.jpeg { redirect_to podcast.image_file.url, status: :found, allow_other_host: true }
      format.rss { redirect_to url_for(podcast.rss_file), status: :found, allow_other_host: true}
      format.js { redirect_to url_for(podcast.js_file), status: :found, allow_other_host: true}
      
    end
  end 

  def not_found
    render status: :not_found
  end

end