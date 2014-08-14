class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer   :user_id, null: false
      t.integer   :fuman_id, null: false
      t.integer   :item_id, null: false
      t.string    :table_name, null: false
      t.string    :column_name, null: false
      t.integer   :target_data
      t.text      :message

      t.timestamps
    end
  end
end
