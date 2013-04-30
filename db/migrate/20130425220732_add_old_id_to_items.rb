class AddOldIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :old_id, :integer
  end
end
