class CategoriesController < ApplicationController
  before_action :find_category, only: :show
  before_action :load_categories, only: [:show, :index]

  def index
    @books = Book.order_desc.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @books = @category.books.order_desc.paginate page: params[:page],
      per_page: Settings.per_page
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      redirect_to categories_path
      flash[:danger] = t "controller.categories.flash_danger"
    end
  end

  def load_categories
    @categories = Category.all
    if @categories.blank?
      flash[:danger] = t "controller.categories.categories_danger"
    end
  end
end
