class Api::MeController < Api::ApplicationController

  def user_timeline
    @target_user = User.find_by_username(params[:user_id])
    return render_not_found if @target_user.blank?

    if @current_user.present?
      @friendship = @current_user.following(@target_user.id)
    end

    @items      = @target_user.items_with_fuman(params, 50)
    @categories = @target_user.categories
  end
end
