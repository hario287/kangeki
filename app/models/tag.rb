class Tag < ApplicationRecord
  has_many :review_tag_relationships,dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ　それは、review_tag_relationshipsを通じて参照できる
  has_many :reviews,through: :review_tag_relationships

  # validates :name, uniqueness: true, presence: true
end
