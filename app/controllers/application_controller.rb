class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "controllers.flash.logged_in"
      redirect_back_or login_url
    end
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "controllers.admin.login.flash.danger"
      redirect_to root_path
    end
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.blank?
      flash[:danger] = t "controllers.flash.find_user_fail"
      redirect_to root_url
    end
  end
end
