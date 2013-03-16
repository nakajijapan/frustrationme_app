class TopController < ApplicationController
  def index
    @current_user = User.find_by_id(session[:user_id]) if session[:user_id].present?
  end
end
