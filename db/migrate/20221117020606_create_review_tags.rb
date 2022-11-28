class CreateReviewTags < ActiveRecord::Migration[6.1]
  def change
    create_table :review_tags do |t|
      t.integer :review_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようになる
    add_index :review_tags, [:review_id, :tag_id], unique: true
  end
end
