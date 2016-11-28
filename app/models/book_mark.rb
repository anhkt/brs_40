class BookMark < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true

  enum read_status: [:unread, :read, :reading]

  scope :favorited, ->{where is_favorite: true}

end
