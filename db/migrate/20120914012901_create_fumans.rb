class CreateFumans < ActiveRecord::Migration
  def change
    create_table :fumans do |t|
      t.integer  :user_id, :null => false
      t.text     :content
      t.integer  :status, :default => 1
      t.integer  :category_id
      t.text     :tag_ids
      t.integer  :item_id

      t.timestamps
    end
  end
end
