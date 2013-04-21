class FriendshipsController < ApplicationController
  before_filter :current_user, only: [:create, :destroy]
  before_filter :check_user, only: [:followings, :followers]

  def create
    target_user = User.where(id: params[:id]).first
    return render_not_found if target_user.blank?
    return render_success('already created') if @current_user.following(target_user.id).present?

    @friendship = Friendship.new({user_id: @current_user.id, following_id: target_user.id})
    @friendship.save

    respond_with @friendship, location: nil
  end

  def destroy
    target_user = User.where(id: params[:id]).first
    return render_not_found if target_user.blank?

    @friendship = @current_user.following(target_user.id)
    return render_not_found if @friendship.blank?

    @friendship.destroy

    respond_with @friendship, notice: 'deleted!'
  end

  def followings
    target_user = User.where(username: params[:username]).first
    return render_not_found if target_user.blank?

    respond_with target_user.followings
  end

  def followers
    target_user = User.where(username: params[:username]).first
    return render_not_found if target_user.blank?

    respond_with target_user.followers
  end
end
