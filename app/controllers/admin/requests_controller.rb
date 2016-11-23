class Admin::RequestsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_request, only: [:edit, :update, :destroy]
  before_action :load_status, only: :edit

  def index
    @requests = Request.order_by_time
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @request.update_attributes request_params
      flash[:success] = t "controllers.requests.update_success"
      redirect_to admin_requests_path
    else
      load_status
      render :edit
    end
  end

  def destroy
    if @request.destroy
      flash[:success] = t "controllers.requests.destroy_success"
    else
      flash[:danger] = t "controllers.requests.destroy_error"
    end
    redirect_to admin_requests_path
  end

  private
  def request_params
    params.require(:request).permit :book_name, :author, :content, :status
  end

  def find_request
    @request = Request.find_by id: params[:id]
    unless @request
      flash[:danger] = t "controllers.admin.request.danger"
      redirect_to admin_requests_path
    end
  end

  def load_status
    @request_statuses = Request.statuses.map{|key, value| [t("controllers.requests.#{key}"), key]}
  end
end
