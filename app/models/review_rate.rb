class ReviewRate < ApplicationRecord
  enum read_status: { Reading: 0, Read: 1, UnRead: 2}

  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy
  
  validates :content, presence: true, length: {minimum: 50, maximum: 5000}
  validates :book, presence: true

  scope :desc, ->{order created_at: :DESC}
end
