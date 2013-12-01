collection @items, root: :items, object_root: false
attribute :id, :service_code, :product_id, :url, :preview_url, :title, :description,
          :release_date, :image_l, :is_adult, :price,
          :created_at, :udated_at

child :last_created_user do
  attributes :id, :username, :icon_name
end