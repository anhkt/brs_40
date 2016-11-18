class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @title = params[:relation]
    @user = User.find_by id: params[:user_id]
    if @user.nil?
      flash.now[:danger] = t "controllers.flash.find_user_fail"
      redirect_to root_path
    else
      @users = @user.send(@title).paginate page: params[:page]
    end
  end

  def create
    @user = User.find_by id: params[:followed_id]
    if @user.nil?
      flash[:danger] = t "controllers.flash.find_user_fail"
      redirect_to root_path
    else
      current_user.follow @user
      @relationship = current_user.active_relationships.find_by followed_id: @user.id
      redirect_to @user
    end
  end

  def destroy
    relationship = Relationship.find_by id: params[:id]
    if relationship.nil?
    	flash[:danger] = t "controllers.relationship.danger"
    	redirect_to root_path
    else
    	followed_user = relationship.followed
    	current_user.unfollow followed_user
    	flash[:success] = t "controllers.relationship.success"
      redirect_to followed_user
    end
  end
end
