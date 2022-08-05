class SessionsController < ApplicationController
  skip_before_action :authenticated, only: [:login, :create, :forgot, :forgot_form, :reset, :reset_form, :do_reset]
  skip_before_action :privileged, only: [:login, :create, :forgot, :forgot_form, :reset, :reset_form, :do_reset, :logout, :destroy]
  layout "clean"
  def create
    @user = User.find_by(email: params[:email])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.podcasts.any?
        session[:podcast_id] = @user.podcasts.first.id  
      else 
        session[:podcast_id] = nil
      end
      redirect_to root_path
    else
      flash[:error] = t(:login_failed)
      redirect_to login_path
    end
  end
  def switch_podcast
    podcast = Podcast.find(params[:podcast][:id])
    if podcast.users.include? current_user
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
