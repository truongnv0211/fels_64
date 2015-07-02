class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.users_per_index
  end

  def show
    @user = User.find params[:id]
    @lessons = Lesson.following_leaned(@user)
      .paginate page: params[:page], per_page: Settings.lessons_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t :welcome
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = t :update_success
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t :user_delete_message
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :username, :email, :password,
      :password_confirmation, :picture
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_path unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
