class Api::UsersController < Api::ApplicationController

  def user_timeline
    @target_user = User.find(params[:user_id])
    return render_not_found if @target_user.blank?

    @items      = @target_user.items_with_fuman(params, 50)
    @categories = @target_user.categories
  end

  def friends_timeline
    @target_user = User.find(params[:user_id])
    return render_not_found if @target_user.blank?

    @items = @target_user.items_with_fuman_for_friends(params, 50)
  end

  def create
    @user = User.new(user_params)
    @user.save!

    sign_in(@user)
    render json: {result: :OK}, status: :created
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :email, :password_confirmation)
    end

end
