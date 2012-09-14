class Fuman < ActiveRecord::Base
  attr_accessible :category_id, :content, :date, :item_id, :price, :priority, :status, :tag_ids, :title, :user_id
end
