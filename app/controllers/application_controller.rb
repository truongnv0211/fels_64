class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  protected
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t :required_user_logged
      redirect_to login_url
    end
  end

  def required_admin
    unless logged_in? && current_user.admin?
      flash[:danger] = t :required_admin_logged
      redirect_to current_user.nil? ? login_path : current_user
    end
  end
end
