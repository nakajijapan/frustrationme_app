class Api::ApplicationController < ActionController::Base
  respond_to :json

  before_filter :require_user

  # 404
  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end

  # [params]
  #   my_user_id
  #   my_key
  def require_user
    @current_user = User.find_by_id(params[:my_user_id])

    # user check
    if @current_user
      hash = @current_user.get_hash

      # key check
      if params[:my_key] != nil
        if hash === params[:my_key]
          return true
        end
      end
    end

    respond_to do |format|
      format.json {render :json => {:logined => false}}
    end
  end
end
