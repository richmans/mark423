class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_podcast
  helper_method :logged_in?
  before_action :authenticated
  before_action :privileged

  def current_user
    User.find_by(id: session[:user_id])
  end

  def current_podcast
    Podcast.find_by(id: session[:podcast_id])
  end

  def logged_in?      
      !current_user.nil?
  end

  def has_podcast?
    !current_podcast.nil?
  end

  def authenticated
    redirect_to login_path unless logged_in?
  end
  def privileged
    redirect_to noprivilege_path unless has_podcast?
  end
end
