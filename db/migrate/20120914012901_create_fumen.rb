class CreateFumen < ActiveRecord::Migration
  def change
    create_table :fumen do |t|
      t.integer :user_id, :null => false
      t.datetime :date
      t.string :title
      t.integer :price, :default => 0
      t.text :content
      t.integer :priority, :default => 2
      t.integer :status, :default => 1
      t.text :tag_ids
      t.integer :category_id
      t.integer :item_id

      t.timestamps
    end
  end
end
