collection @items, root: :items, object_root: false
attributes :id, :service_code, :product_id, :url, :preview_url, :title, :description,
          :release_date, :image_l, :is_adult, :price,
          :created_at, :udated_at

node(:fuman_id) do |item|
  item.fuman.id
end

child :fuman do
  attributes :id, :status, :category_id

  child :user do
    attributes :id, :username
  end
end

child @target_user => :target_user do
  attributes :id, :username
end