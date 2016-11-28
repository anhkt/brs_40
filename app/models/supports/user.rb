class Supports::User
  attr_reader :user

  def initialize user
    @user = user  
  end

  def reading_book
    @reading_books = Book.reading_books @user
  end

  def read_book
    @read_books = Book.read_books @user
  end

  def favorite
    @favorite_books = Book.favorite_books @user
  end
end
