class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  belongs_to :topic

  # バリデーション
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true
  validates :topic, presence: true
  # 画像がつけられる
  has_one_attached :post_image

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end
end
