class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer   :service_code
      t.integer   :product_id
      t.string    :url,     :limit => 1024
      t.string    :preview_url, :limit => 1024
      t.string    :title, :limit => 512
      t.text      :description
      t.datetime  :release_date
      t.string    :image_s, :limit => 1024
      t.string    :image_m, :limit => 1024
      t.string    :image_l, :limit => 1024
      t.integer   :is_adult
      t.integer   :price

      t.timestamps
    end
  end
end
