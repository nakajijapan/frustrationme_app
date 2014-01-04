class FumansController < ApplicationController
  before_filter :require_user, except: [:new]

  def index
    @items      = @current_user.items_with_fuman(params, 30)
    @categories = @current_user.categories
  end

  def new
    @categories = current_user.categories if current_user.present?
    render :new, layout: false
  end

  def search
    @items         = {}
    @checked_items = {}
    @categories    = @current_user.categories

    # search items
    if params[:s_keywords].present?
      service = ApiBucket::Service.instance(:"#{params[:s_service_name]}")
      res     = service.search(params[:s_keywords], {count: 16, search_index: params[:s_category]})
      @items  = res.items

      # get items which user has
      if @items.present?
        product_codes  = @res.items.map {|i| i.product_code}
        @checked_items = @current_user.checked_items(product_codes)
      end
    end
  end

  def create_with_item
    service_fuman = ServiceFuman.new(@current_user)

    if params[:item][:service_code].to_i == Item::SERVICE_CODE_FRUSTRATION
      saved = service_fuman.create_with_item_using_frustration(item_params, fuman_params)
    else
      saved = service_fuman.create_with_item(item_params, fuman_params)
    end

    respond_to do |format|
      if saved
        format.json { render json: service_fuman.fuman, status: :created }
      else
        format.json { render json: {error: 'error'}, status: :unprocessable_entity }
      end
    end
  end

  def update
    @fuman = Fuman.find(params[:id])

    params[:fuman][:user_id] = @current_user.id
    @fuman.update_attributes(fuman_params)

    respond_with @fuman, :notice => 'created!', :location => '/'
  end

  def destroy
    @fuman = @current_user.delete_fuman(params[:id])
    respond_with @fuman
  end

  def categories
    h = {}
    ApiBucket::Service.instance(:"#{params[:type]}").categories.each_pair {|k,v| h[v]=k}
    @categories = h rescue(return render_not_found)
    respond_with @categories, layout: false
  end

  private
    def fuman_params
      params.require(:fuman).permit(:user_id, :item_id, :status, :category_id)
    end

    def item_params
      params.require(:item).permit(:service_code, :product_id, :title, :url, :image_l)
    end
end
