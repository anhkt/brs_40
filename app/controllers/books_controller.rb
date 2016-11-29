class BooksController < ApplicationController
  before_action :find_book, only: :show
  before_action :logged_in_user
  before_action :load_mark, only: [:edit, :update, :show]


  def index
    @books = Book.search(params[:search]).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    load_mark
    @reviews = @book.review_rates.descending.paginate page: params[:page],
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

  def load_mark
    @book_mark_types = BookMark.mark_types
      .map{|key, value| [t("controllers.book_mark.#{key}"), key]}
  end
end
