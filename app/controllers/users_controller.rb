class UsersController < ApplicationController
  before_filter :check_user, only: :show

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

    @friendship = @current_user.following(@target_user.id)
    @items      = @target_user.items_with_fuman(params, 50)
    @categories = @target_user.categories
  end
end
