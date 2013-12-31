class TopController < ApplicationController

  def index
    @items = Item.public_timeline(params)
  end

end
