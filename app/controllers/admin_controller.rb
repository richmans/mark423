class AdminController < ApplicationController
  helper_method :current_user
  helper_method :current_podcast
  helper_method :logged_in?
  helper_method :is_admin?
  helper_method :current_role
  before_action :authenticated
  before_action :privileged
  helper_method :is_at_least
  helper_method :my_podcasts

  def my_podcasts
    if is_admin?
      return Podcast.all.collect{|a|[a.name, a.id]}
    else
      return current_user.podcasts.collect{|a|[a.name, a.id]}
    end
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def is_admin?
    current_user.is_admin
  end

  def is_at_least?(required_role)
    if is_admin?
      return true
    end
    current_role_index = Privileges.roles[current_role]
    required_role_index = Privileges.roles[required_role.to_s]
    return current_role_index >= required_role_index
  end

  def current_role
    if is_admin?
      return 'admin'
    end
    return Privilege.find_by(user: current_user, podcast: current_podcast).role
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
    redirect_to noprivilege_path unless has_podcast? or is_admin?
  end

  def authorized_admin
    if not is_admin?
      redirect_to login_path
    end
  end
end
