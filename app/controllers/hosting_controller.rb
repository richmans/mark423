class HostingController < ApplicationController
  include RssCacheHelper
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
      format.png { redirect_to recording.image_file.url, status: :found, allow_other_host: true}
    end
  end

  def player
    redirect_to ActionController::Base.helpers.asset_path("mark423-player.js")
  end

  def serve_file(podcast, attachment, extension, mime)
    filename = podcast.shortname + "." + extension
    local_path = get_local_path(filename)
    if not File.exists?(local_path)
      File.open(local_path, 'wb') do |file| 
        file.write(attachment.download) 
      end          
    end
    
    send_file(local_path,
      :filename => filename,
      :type => mime)
    
  end
  

  def fetch_podcast
    podcast = Podcast.find_by(shortname: params[:podcast])
    return nope if podcast.nil?
    respond_to do |format|
      format.jpeg { serve_file podcast, podcast.image_file, "jpg", "image/jpeg" }
      format.png { serve_file podcast, podcast.image_file, "png", "image/png" }
      format.rss { serve_file podcast, podcast.rss_file, "rss", "application/rss+xml"}
      format.js { serve_file podcast, podcast.js_file, "js", "text/javascript"}
      
    end
  end 

  def not_found
    render status: :not_found
  end

end
