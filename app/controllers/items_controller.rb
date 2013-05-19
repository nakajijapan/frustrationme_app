class ItemsController < ApplicationController
  before_filter :check_user, only: :show

  def show
    # categories
    @categories = []
    @categories = @current_user.categories if @current_user.present?

    # item
    @item = Item.find(params[:id])

    # 登録された商品かどうか
    @registered = false
    @registered = true if @current_user.present? && @current_user.checked_items(@item.product_id).present?

    # 登録されたユーザ一覧
    @registers = {}
    @registers[:want]       = @item.users_with_status(1)
    @registers[:has]        = @item.users_with_status(2)
    @registers[:give]       = @item.users_with_status(3)
    @registers[:experience] = @item.users_with_status(4)
    @registers[:had]        = @item.users_with_status(5)
  end
end
