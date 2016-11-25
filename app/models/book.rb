class Book < ApplicationRecord
  belongs_to :category, optional: true

  has_many :book_marks, dependent: :destroy
  has_many :review_rates, dependent: :destroy
  has_many :ratings
  
  mount_uploader :cover, PictureUploader

  validates :title, presence: true, length: {maximum: 140}
  validates :number_of_page,
    numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validates :author, presence: true, length: {maximum: 50}
  validates :description, presence: true
  validates :category, presence: true

  scope :order_desc, ->{order created_at: :DESC}
  scope :publish_date_order_desc, ->{order publish_date: :DESC}

  BookMark.read_statuses.keys.each do |name|
    scope :"#{name}_books",
    ->user {where id: user.book_marks.send(name).pluck(:book_id)}
  end

  def rated? user
    self.ratings.find_by user: user
  end
end
