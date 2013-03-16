class FumansController < ApplicationController
  before_filter :current_user

  def search
    logger.warn params

    @categories = @current_user.categories

    @items = {}
    @checked_items = {}

    # search items
    if params[:s_keywords].present?
      service = ApiBucket::Service.instance(:"#{params[:s_service_name]}")
      res     = service.search(params[:s_keywords], {count: 16, search_index: params[:s_category]})
      @items  = res.items

      # get items checked
      if @items.present?
        code_list      = @items.map {|i| i.product_code}
        @checked_items = @current_user.checked_items(code_list)
      end
    end
  end

  def create_with_item
    logger.warn params

    service_fuman = ServiceFuman.new(@current_user)
    saved = service_fuman.create_with_item(params[:item], params[:fuman])

    respond_with service_fuman.fuman, :notice => 'created!', :location => '/'
    #respond_with do |format|
    #  format.json { render :json => service_fuman.fuman, status: 201}
    #end
  end

  def categories
    h = {}
    ApiBucket::Service.instance(:"#{params[:type]}").categories.each_pair {|k,v| h[v]=k}
    @categories = h rescue(return render_not_found)
    respond_with @categories, layout: false
  end
end
