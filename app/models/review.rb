class Review < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  # タグのリレーション
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  # 画像がつけられる
  has_one_attached :review_image
  # いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # バリデーション
  validates :stage_name, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 500 }
  validates :stage_prefecture, presence: true
  validates :rate, presence: true

  # レビュー評価
  validates :rate, numericality: {
  less_than_or_equal_to: 5,
  greater_than_or_equal_to: 1 }, presence: true


  # 公演場所
  enum stage_prefecture: {
     "---": 0,
     北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
     茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
     新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
     岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
     滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
     鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
     徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
     福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46,
     沖縄県: 47
   }

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    # Create new taggings:
    new_tags.each do |new|
      new_review_tag = Tag.find_or_create_by(name: new)
      # 配列に保存
      self.tags << new_review_tag
    end
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @review = Review.where("stage_name LIKE?", "#{word}")
    elsif search == "forward_match"
      @review = Review.where("stage_name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @review = Review.where("stage_name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @review = Review.where("stage_name LIKE?", "%#{word}%")
    else
      @review = Review.all
    end
  end
end
