class ItemsController < ApplicationController
  before_filter :current_user, only: :show

  def show
    logger.warn params
    @item = Item.find(params[:id])

    # 登録されたユーザ一覧
    @registers = {}
    @registers[:want]       = @item.users_with_status(1)
    @registers[:has]        = @item.users_with_status(2)
    @registers[:give]       = @item.users_with_status(3)
    @registers[:experience] = @item.users_with_status(4)
    @registers[:had]        = @item.users_with_status(5)

    # コメント一覧
    @comments = @item.comment_list
    logger.warn @comments.inspect
  end
end
