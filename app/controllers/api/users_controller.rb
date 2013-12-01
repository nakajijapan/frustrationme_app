class Api::UsersController < Api::ApplicationController

  def user_timeline
    @target_user = User.find(params[:user_id])
    return render_not_found if @target_user.blank?

    @items      = @target_user.items_with_fuman(params, 50)
    @categories = @target_user.categories
  end

end
