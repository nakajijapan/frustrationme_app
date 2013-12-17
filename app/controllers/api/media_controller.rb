class Api::MediaController < Api::ApplicationController
  skip_filter :require_user

  def public_timeline
    @items = Item.public_timeline(params)
  end

end
