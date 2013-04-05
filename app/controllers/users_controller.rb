class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save

    respond_with @user, :location => root_url, :notice => 'created!'
  end

  def show
    @target_user = User.find_by_username(params[:username])
    return render_not_found if @target_user.blank?

    logger.warn @target_user

    @items     = @target_user.items_with_fuman(params, 50)
    @categories = @target_user.categories
  end
end
