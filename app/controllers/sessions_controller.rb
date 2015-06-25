class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      params[:session][:remember_me] == Settings.CHECKBOOK_TRUE ? 
        remember(user) : forget(user)
      redirect_to user.admin? ? admin_root_path : user
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
