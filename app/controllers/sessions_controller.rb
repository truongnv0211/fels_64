class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.CHECKBOX_TRUE ?
        remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t :alert_login_invalid
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
