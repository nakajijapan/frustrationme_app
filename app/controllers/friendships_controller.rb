class FriendshipsController < ApplicationController
  before_filter :require_user, only: [:create, :delete]

  def create
    target_user = User.where(id: params[:following_id]).first
    return render_not_found if target_user.blank?
    return render_success('already created') if @current_user.following(target_user.id).present?

    @friendship = Friendship.new({user_id: @current_user.id, following_id: target_user.id})
    @friendship.save

    respond_with @friendship, location: nil
  end

  def delete
    @friendship = @current_user.unfollow(params[:following_id])

    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

  def followings
    @target_user = User.where(username: params[:username]).first
    return render_not_found if @target_user.blank?

    @users = @target_user.followings

    if current_user.present?
      @current_friends = current_user.following_ids(@users.map{|f| f.following_id})
    end

    respond_with @users
  end

  def followers
    @target_user = User.where(username: params[:username]).first
    return render_not_found if @target_user.blank?

    @users = @target_user.followers

    if current_user.present?
      @current_friends = current_user.following_ids(@users.map{|f| f.user_id})
    end

    respond_with @users
  end

end
