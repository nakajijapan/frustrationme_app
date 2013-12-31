class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json

  # 404
  def render_not_found
    if params[:format] == 'json'
      render :json => {:error => "not_found"}.to_json, status: :not_found, layout: false
    else
      render file: "#{Rails.root}/public/404", status: :not_found, layout: false
    end
  end

  # app success
  def render_success(msg='')
    if params[:format] == 'json'
      render json: {info: msg}.to_json, status: 200, layout: false
    else
      render file: "#{Rails.root}/public/500", status: 500, layout: false
    end
  end

  def exception
    if env["REQUEST_PATH"] =~ /^\/api/ or params[:format] == 'json'
      render :json => {:error => "internal_server_error"}.to_json, :status => 500
    else
      render file: "#{Rails.root}/public/500", :status => 500, layout: false
    end
  end

  def signed_in?
    !!current_user
  end

  def require_user
    return if signed_in?
    redirect_to :root
  end

  def current_user
    return nil if session[:user_id].nil?
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user=(user)
    @current_user = user
  end

end
