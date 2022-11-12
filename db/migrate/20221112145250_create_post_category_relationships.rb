class CreatePostCategoryRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :post_category_relationships do |t|
      t.integer :post_id, null: false
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
