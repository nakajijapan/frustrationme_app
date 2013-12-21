class Api::FriendshipsController < Api::ApplicationController
  skip_filter :require_user

  def create
    target_user = User.where(id: params[:following_id]).first
    return render_not_found if target_user.blank?
    return render_success('already created') if current_user.following(target_user.id).present?

    @friendship = Friendship.new({user_id: current_user.id, following_id: target_user.id})
    @friendship.save
  end

  def delete
    @friendship = current_user.unfollow(params[:following_id])
    head :no_content
  end

end
