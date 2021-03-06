node :items do
  partial('api/users/friends_items', object: @items)
end

node :paginator do
  {
    current_page: @items.current_page,
    next: !@items.last_page?,
    back: !@items.first_page?
  }
end