class RatingsController < ApplicationController
  before_action :logged_in_user
  before_action :find_book

  def create
    @rating = Rating.new book: @book,
      rate: rating_params[:rate], user_id: current_user.id
    if @rating.save
      @rate = @book.ratings.average(:rate) || 0
      respond_to do |format|
        format.html do
          flash[:success] = t "controllers.ratings.rate_success"
          redirect_to @book
        end
        format.js
      end
    end
  end

  private
  def find_book
    @book = Book.find_by id: params[:book_id]
    if @book.nil?
      redirect_to books_path
      flash[:danger] = t "controllers.books.book_blank"
    end
  end

  def rating_params
    params.require(:rating).permit :rate
  end
end
