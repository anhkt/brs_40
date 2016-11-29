class ReviewRate < ApplicationRecord
  include ActivityConcern
  enum mark_type: [:unread, :read, :reading]

  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy
  
  validates :content, presence: true, length: {minimum: Settings.minimum,
    maximum: Settings.maximum}
  after_save :create_activity_for_review
  before_destroy :remove_activity_for_review
  validates :book, presence: true
  has_many :activities

  scope :descending, ->{order created_at: :DESC}
  
  private
  def create_activity_for_review
    create_activity Activity.activity_types[:review], self.user_id, self.id
  end

  def remove_activity_for_review
    remove_activity Activity.activity_types[:review], self.user_id, self.id
  end
end
