class CommentsController < ApplicationController
  before_filter :current_user, except: [:index]

  def index
    @comments = Comment.timeline(params)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = @current_user.id
    @comment.save

    respond_with @comment, :location => '/settings/comments'
  end

  def update
    @comment = Comment.find(params[:id])
    params[:comment][:user_id] = @current_user.id
    @comment.update_attributes(comment_params)

    respond_with @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    #Comment.delete_all(['user_id = ? and id = ?', @current_user.id, params[:id]])

    respond_with @comment
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :item_id, :text)
    end
end
