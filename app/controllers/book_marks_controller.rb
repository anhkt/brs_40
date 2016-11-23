class BookMarksController < ApplicationController
  before_action :logged_in_user
  before_action :load_mark, only: [:edit, :update]
  before_action :load_book
 
  def create
    @book_mark = @book.book_marks.build book_marks_params
    if @book_mark.save
      flash[:success] = t "controllers.book_mark.success"
    else
      flash[:danger] = t "controllers.book_mark.danger"
    end
    redirect_to @book
  end

  def edit
  end

  def update
    if @book_mark.update_attributes book_marks_params
      flash[:success] = t "controllers.book_mark.success"
    else
      flash[:danger] = t "controllers.book_mark.danger"
    end
    redirect_to @book
  end

  private
  def book_marks_params
    params.require(:book_mark).permit :read_status, :user_id, :book_id
  end

  def load_mark
    @book_mark = BookMark.find_by id: params[:id]
    if @book_mark.nil?
      flash[:danger] = t "controllers.book_mark.not"
      redirect_to @book
    end
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    if @book.nil?
      flash[:danger] = t "controllers.books.book_blank"
      redirect_to categories_path
    end
  end
end
