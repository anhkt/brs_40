class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :find_user, except: [:index, :new, :create]
  before_action :valid_user, only: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user 
      flash.now[:success] = t "controllers.flash.login_success"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controllers.flash.update_success"
      redirect_to @user
    else
      render :edit
    end
  end 

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def valid_user
    redirect_to root_url unless @user.current_user? current_user
  end
end
