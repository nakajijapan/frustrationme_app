class Api::ItemsController < Api::ApplicationController
  skip_filter :require_user

  def show
    # item
    @item = Item.find(params[:id])

    # 登録された商品かどうか
    @registered = false
    @registered = true if @current_user.present? && @current_user.checked_items(@item.product_id).present?
  end
end
