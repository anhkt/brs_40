class ReviewRate < ApplicationRecord
  enum read_status: {unread: 0, read: 1, reading: 2}

  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy
  
  validates :content, presence: true, length: {minimum: Settings.minimum,
    maximum: Settings.maximum}
  validates :book, presence: true

  scope :desc, ->{order created_at: :DESC}
end
