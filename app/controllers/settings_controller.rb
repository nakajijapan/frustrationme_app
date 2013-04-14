class SettingsController < ApplicationController
  before_filter :current_user

  def profile
    #@user = User.find()
  end

  def category
    #@category = Category.new
  end
end
