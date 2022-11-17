class Category < ApplicationRecord
  has_many :posts
  validates :category_name, uniqueness: true, presence: true
end
