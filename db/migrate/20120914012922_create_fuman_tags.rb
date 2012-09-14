class CreateFumanTags < ActiveRecord::Migration
  def change
    create_table :fuman_tags do |t|
      t.integer :fuman_id, :null => false
      t.integer :user_id, :null => false
      t.integer :item_id, :null => false
      t.integer :tag_id, :null => false

      t.timestamps
    end
  end
end
