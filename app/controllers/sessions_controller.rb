class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:login, :create, :forgot, :forgot_form, :reset, :reset_form, :do_reset]
  layout "clean"
  def create
    @user = User.find_by(email: params[:email])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = t(:login_failed)
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
