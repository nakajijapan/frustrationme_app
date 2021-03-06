class Api::FollowersController < Api::ApplicationController
  skip_filter :require_user

  def index
    @target_user = User.find(params[:user_id])
    return render_not_found if @target_user.blank?

    @users = @target_user.followers

    if current_user.present?
      @current_friends = @current_user.following_ids(@users.map{|f| f.user_id})
    end
  end

end
