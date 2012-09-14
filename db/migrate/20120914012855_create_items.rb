class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :type
      t.integer :product_id
      t.string :url,     :limit => 1024
      t.string :url_media, :limit => 1024
      t.text :description
      t.datetime :date
      t.string :image_s, :limit => 1024
      t.string :image_m, :limit => 1024
      t.string :image_l, :limit => 1024
      t.integer :is_adult

      t.timestamps
    end
  end
end
