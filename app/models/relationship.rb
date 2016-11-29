class Relationship < ApplicationRecord
  include ActivityConcern
  belongs_to :follower, class_name: User.name 
  belongs_to :followed, class_name: User.name 

  validates :follower, presence: true
  validates :followed, presence: true
  after_save :create_activity_for_follow
  before_destroy :remove_activity_for_follow
  has_many :activitiess
  
  private
  def create_activity_for_follow
    create_activity Activity.activity_types[:follow],
      self.follower_id, self.followed_id
  end

  def remove_activity_for_follow
    remove_activity Activity.activity_types[:follow],
      self.follower_id, self.followed_id
  end
end
