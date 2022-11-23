class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :stage_prefecture, null: false
      t.string :stage_name, null: false
      t.string :group, null: false
      t.text :body, null: false
      t.float :rate, null: false, default: 0

      t.timestamps
    end
  end
end
