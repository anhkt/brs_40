class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rate, presence: true,
    inclusion: {in: Settings.ratings.min_rate..Settings.ratings.max_rate}
end
