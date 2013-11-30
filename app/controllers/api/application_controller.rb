class Api::ApplicationController < ActionController::Base

  respond_to :json
  before_filter :require_user

  # 404
  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end

  def require_user
    return if signed_in?
    render json: {result: :NG, message: 'auth error'}
  end

  def sign_in(user)
    user.auth_token = cookies[:auth_token] = User.new_auth_token
    user.update_attribute(:auth_token, user.auth_token)
    current_user = user
  end

  def signed_in?
    !!@current_user
  end

  def current_user(auth_token)
    @current_user ||= User.find_by_auth_token(auth_token)
  end

  def current_user=(user)
    @current_user = user
  end

end
