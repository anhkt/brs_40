class Request < ApplicationRecord
  belongs_to :user
  validates :book_name, presence: true, length: {maximum: 50}
  validates :author, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 200}
  
  enum status: [:waiting, :accept, :deny]
  scope :order_by_time, ->{order created_at: :desc}
end
