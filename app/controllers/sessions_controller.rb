class SessionsController < AdminController
  skip_before_action :authenticated, only: [:login,:create]
  skip_before_action :privileged, only: [:create, :login, :destroy]
  layout "clean"
  def create
    @user = User.find_by(email: params[:email])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.podcasts.any?
        session[:podcast_id] = @user.podcasts.first.id
        redirect_to recordings_path(format: :html)
      else 
        session[:podcast_id] = nil
        redirect_to podcasts_path(format: :html)
      end
      
    else
      flash[:error] = t(:login_failed)
      redirect_to login_path
    end
  end
  def switch_podcast
    podcast = Podcast.find(params[:podcast][:id])
    if podcast.users.include? current_user or is_admin?
      session[:podcast_id] = podcast.id
    end
    redirect_to recordings_path
  end
  def destroy
    session[:user_id] = nil
    session[:podcast_id] = nil
    redirect_to root_path
  end
end
