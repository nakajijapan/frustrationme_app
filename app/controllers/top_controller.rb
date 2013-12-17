class TopController < ApplicationController
  before_filter :check_user

  def index
    @items = Item.public_timeline(params)
  end
end
