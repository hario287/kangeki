class Category < ApplicationRecord
  has_many :posts
  validates :name, uniqueness: true, presence: true
end
