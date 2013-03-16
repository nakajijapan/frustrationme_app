class Item < ActiveRecord::Base
  attr_accessible :product_id, :release_date, :description, :url, :preview_url
  attr_accessible :image_l, :image_m, :image_s, :is_adult, :service_code, :price, :title

  has_one :fuman
end
