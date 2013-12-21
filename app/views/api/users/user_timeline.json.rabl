node :items do
  partial('api/users/user_items', object: @items)
end

node :categories do
  partial('api/categories/user', object: @categories)
end

node :paginator do
  {
    current_page: @items.current_page,
    next: !@items.last_page?,
    back: !@items.first_page?
  }
end