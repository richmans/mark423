class RenderController < AdminController
  skip_before_action :verify_authenticity_token


  skip_before_action :authenticated
  skip_before_action :privileged
  before_action :set_podcast

  def set_podcast
    @podcast = Podcast.find_by(shortname: params[:podcast_name])
  end
end
