class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    follow = params[:type]
    if Settings.follow_type.include? follow
      @title = t follow
      @user = User.find params[:id]
      @users = @user.send(follow).paginate page: params[:page],
        per_page: Settings.users_per_index
    else
      redirect_to @user
    end
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
