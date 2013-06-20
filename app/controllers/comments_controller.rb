class CommentsController < ApplicationController
  before_filter :current_user, except: [:index]
  protect_from_forgery except: :destroy

  def index
    @comments = Comment.timeline(params)
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = @current_user.id
    @comment.save

    respond_with @comment, :location => '/settings/comments'
  end

  def update
    @comment = Comment.find(params[:id])
    params[:comment][:user_id] = @current_user.id
    @comment.update_attributes(params[:comment])

    respond_with @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #Comment.delete_all(['user_id = ? and id = ?', @current_user.id, params[:id]])

    respond_with @comment
  end
end
