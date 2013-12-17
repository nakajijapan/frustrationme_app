node :items do
  partial('api/users/user_items', object: @items)
end

node :categories do
  partial('api/categories/user', object: @categories)
end