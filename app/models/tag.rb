class Tag < ApplicationRecord
  has_many :review_tags,dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ　それは、review_tagsを通じて参照できる
  has_many :reviews,through: :review_tags

  scope :merge_reviews, -> (tags){ }

  def self.search_reviews_for(content, method)

    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'forward'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('name LIKE ?', '%' + content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end

    return tags.inject(init = []) {|result, tag| result + tag.reviews}

  end
end
