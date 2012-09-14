class CreateFrendships < ActiveRecord::Migration
  def change
    create_table :frendships do |t|
      t.integer :user_id, :null => false
      t.integer :following_id, :null => false

      t.timestamps
    end
  end
end
