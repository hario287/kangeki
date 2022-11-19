class Topic < ApplicationRecord
  has_many :posts
  validates :topic_name, uniqueness: true, presence: true
end
