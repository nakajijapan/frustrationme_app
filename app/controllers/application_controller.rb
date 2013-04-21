class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json

  # 404
  def render_not_found
    if params[:format] == 'json'
      render :json => {:error => "not_found"}.to_json, status: :not_found, layout: false
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end

  # app success
  def render_success(msg='')
    render json: {info: msg}.to_json, status: 200, layout: false
  end

  def exception
    if env["REQUEST_PATH"] =~ /^\/api/ or params[:format] == 'json'
      render :json => {:error => "internal_server_error"}.to_json, :status => 500
    else
      render file: "#{Rails.root}/public/500.html", :status => 500
    end
  end

  def current_user
    redirect_to :root if session[:user_id].blank?

    @current_user = User.find_by_id(session[:user_id])
    redirect_to :root if @current_user.nil?
  end

  def check_user
    @current_user = User.find_by_id(session[:user_id])
  end
end
