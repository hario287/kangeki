class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  belongs_to :topic

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true
  validates :topic, presence: true

  has_one_attached :post_image

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end
end
