class BookMark < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true

  enum read_status: {unread: 0, read: 1, reading: 2}

  scope :favorited, ->{where is_favorite: true}

end
