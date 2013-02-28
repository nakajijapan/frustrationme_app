class HomeController < ApplicationController
  before_filter :current_user

  def index
  end

end
