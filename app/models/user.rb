class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed

  has_many :reviews, dependent: :destroy
  has_many :review_comments, dependent: :destroy


  # validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # validates :introduction

  # ゲストユーザー
  def self.guest
    find_or_create_by!(name: 'GuestUser', email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "GuestUser"
    end
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

   # フォローをしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end
end
