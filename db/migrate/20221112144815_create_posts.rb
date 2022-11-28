class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.references :topic, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
