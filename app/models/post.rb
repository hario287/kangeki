class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  belongs_to :category

  validates :title,presence:true
  validates :body,presence:true

  has_one_attached :post_image

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
