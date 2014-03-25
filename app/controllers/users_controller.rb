class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    saved = @user.save

    UserMailer.regist(@user).deliver if saved

    respond_with @user, location: '/login', notice: 'created!'
  end

  def show
    @target_user = User.find_by_username(params[:username])
    return render_not_found if @target_user.blank?

    if current_user.present?
      @friendship = current_user.following(@target_user.id)
    end

    @items      = @target_user.items_with_fuman(params, 60)
    @categories = @target_user.categories
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :email, :password_confirmation)
    end

end
