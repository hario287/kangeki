class Topic < ApplicationRecord
  has_one :posts
  validates :topic_name, uniqueness: true, presence: true
end
