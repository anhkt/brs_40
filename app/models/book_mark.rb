class BookMark < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true

  enum mark_type: [:unread, :read, :reading, :favorite]

end
