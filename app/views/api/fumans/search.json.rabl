node :items do
  partial('api/fumans/items', object: @res.items)
end

node(:service_name) { params[:service_name] }
node(:category) { params[:category] }

node :paginator do
  {
    total_pages:   @res.total_pages,
    item_page:     @res.item_page,
    total_results: @res.total_results
  }
end