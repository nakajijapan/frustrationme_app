class TopController < ApplicationController
  before_filter :check_user

  def index
    @items = Item.index_list(params)
  end
end
