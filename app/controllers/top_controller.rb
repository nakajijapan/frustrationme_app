class TopController < ApplicationController
  before_filter :signed_in?

  def index
    @items = Item.public_timeline(params, 50)
  end

end
