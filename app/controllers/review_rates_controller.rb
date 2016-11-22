class ReviewRatesController < ApplicationController
  before_action :logged_in_user
  before_action :find_book
  before_action :find_review, except: [:new, :create]

  def new
    @review = ReviewRate.new
  end

  def create
    @review = current_user.review_rates.build review_params
    @review.book_id = @book.id
    if @review.save
      redirect_to book_path @book
      flash[:success] = t "controllers.reviews.flash_success"
    else
      render :new
    end
  end

  def show
    @comment = current_user.comments.build
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "controllers.reviews.update_success"
      redirect_to book_path @book
    else
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "controllers.reviews.destroy_success"
    else
      flash[:danger] = t "controllers.reviews.destroy_fail"
    end
    redirect_to book_path @book
  end

  private
  def review_params
    params.require(:review_rate).permit :content, :book_id, :read_status
  end

  def find_review
    @review = ReviewRate.find_by id: params[:id]
    if @review.nil?
      redirect_to book_path @book
      flash[:danger] = t "controllers.reviews.find_review_fail"
    end
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    if @book.nil?
      redirect_to books_path
      flash[:danger] = t "controllers.books.book_blank"
    end
  end
end
