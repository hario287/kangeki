class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  belongs_to :topic
  has_many :view_counts, dependent: :destroy

  validates :title,presence: true, length: { maximum: 30 }
  validates :body,presence: true
  validates :topic, presence: true

  has_one_attached :post_image

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
