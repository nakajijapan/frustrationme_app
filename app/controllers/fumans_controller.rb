class FumansController < ApplicationController
  before_filter :current_user

  def search
    logger.warn params

    @categories = @current_user.categories

    @items = {}
    if params[:s_keywords].present?
      service = ApiBucket::Service.instance(:"#{params[:s_type]}")
      res = service.search(params[:s_keywords], {count: 18, search_index: params[:s_category]})

      @items = res.items
      logger.warn "count = #{res.items}"
    end


  end

  def create

  end

  def categories
    h = {}
    ApiBucket::Service.instance(:"#{params[:type]}").categories.each_pair {|k,v| h[v]=k}
    @categories = h rescue(return render_not_found)
    respond_with @categories, layout: false
  end
end
