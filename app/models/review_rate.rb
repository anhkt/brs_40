class ReviewRate < ApplicationRecord
  enum mark_types: [:unread, :read, :reading, :favorite]

  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy
  
  validates :content, presence: true, length: {minimum: Settings.minimum,
    maximum: Settings.maximum}
  validates :book, presence: true

  scope :desc, ->{order created_at: :DESC}
end
