class Item < ActiveRecord::Base
  attr_accessible :date, :description, :image_l, :image_m, :image_s, :is_adult, :product_id, :type, :url
end
