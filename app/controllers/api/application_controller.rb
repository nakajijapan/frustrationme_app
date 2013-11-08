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
    @current_user = User.find_by_id(params[:user_id])

    # user check
    if @current_user
      hash = @current_user.token

      # key check
      if params[:token] != nil
        if hash == params[:token]
          return true
        end
      end
    end

    render json: {status: false, message: 'logged out'}
  end
end
