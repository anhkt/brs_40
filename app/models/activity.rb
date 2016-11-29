class Activity < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  enum activity_type: [:review, :comment, :follow]

  scope :desc, -> {order created_at: :desc}

  def target_activity
    if review?
      review = ReviewRate.find_by id: target_id
      review ? review.book : nil
    elsif follow?
      User.find_by id: target_id
    elsif comment?
      comment = Comment.find_by id: target_id
      comment ? comment.review_rate : nil
    else
      Book.find_by id: target_id
    end
  end
end
