node :items do
  partial('api/users/friends_items', object: @items)
end
