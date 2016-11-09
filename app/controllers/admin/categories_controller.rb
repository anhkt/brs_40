class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
    if @categories.blank?
      flash[:danger] = t "controllers.categories.category_blank"
      render :new
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controllers.categories.flash_create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "controllers.categories.flash_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "controllers.categories.flash_delete_success"
    else
      flash[:success] = t "controllers.categories.flash_delete_fail"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :category_name
  end

  def find_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "controllers.categories.flash_find_fails"
      redirect_to admin_categories_path
    end
  end
end
