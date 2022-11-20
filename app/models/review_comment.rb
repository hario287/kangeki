class ReviewComment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :review_comment, presence: true
end