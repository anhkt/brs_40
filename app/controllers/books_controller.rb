class BooksController < ApplicationController
  include BookConcerns
  before_action :find_book, only: :show
  
  def index
    @books = Book.search(params[:search]).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @reviews = @book.review_rates.desc.paginate page: params[:page],
      per_page: Settings.per_page
    @book_marked = @book.book_marks.find_by user_id: current_user.id
    if @book_marked.nil?
      @book_mark = @book.book_marks.build
    end
    @rating = @book.ratings.build
    @rate = @book.ratings.average(:rate) || 0
  end

  private
  def find_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:danger] = t "controllers.books.book_blank"
      redirect_to books_path
    end
  end
end
