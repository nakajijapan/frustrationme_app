class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, :null => false
      t.integer :item_id, :null => false
      t.text    :text

      t.timestamps
    end
  end

end
