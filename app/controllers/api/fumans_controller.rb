class Api::FumansController < Api::ApplicationController
  skip_filter :require_user

  def statuses
    respond_with Fuman::STATUSES
  end

  def search
    raise ArgumentError, 'service_name is required' if params[:service_name].nil?
    raise ArgumentError, 'category is required' if params[:category].nil?

    @checked_itms = {}
    @res          = {}

    # search items
    service = ApiBucket::Service.instance(:"#{params[:service_name]}")
    @res    = service.search(params[:keywords], {count: 25, search_index: params[:category]})

    # get items which user has
    if @res.items.present?
      product_codes = @res.items.map {|i| i.product_code}
      @checked_itms = current_user.checked_items(product_codes)
    end
  end

end
