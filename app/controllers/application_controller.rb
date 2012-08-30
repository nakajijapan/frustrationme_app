class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json

  # 404
  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end

  def require_user
    redirect_to :root if session[:user_id].blank?

    if @current_user = User.find(session[:user_id])
      redirect_to :root if @current_user.nil?
    end

    @current_user
  end
end
