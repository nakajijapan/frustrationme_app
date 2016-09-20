class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer   :user_id, null: false
      t.integer   :item_id, null: false
      t.string    :event_type, null: false
      t.text      :message, null: false

      t.timestamps
    end
  end
end
