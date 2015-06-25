class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.admin?
        log_in user
        redirect_to admin_root_path
      else
        log_in user
        flash[:success] = t :alert_login_success
        redirect_to user
      end
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
