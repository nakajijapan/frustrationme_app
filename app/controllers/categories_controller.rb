class CategoriesController < ApplicationController
  before_filter :require_user

  def index
    @categories = @current_user.categories

    respond_to do |format|
      format.html
      format.json { render json: @categories  }
    end
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = @current_user.id
    @category.save

    respond_with @category, location: '/settings/categories'
  end

  def update
    @category = Category.find(params[:id])
    params[:category][:user_id] = @current_user.id
    @category.update_attributes(category_params)

    respond_with @category
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_with @category
  end

  private
    def category_params
      params.require(:category).permit(:user_id, :name)
    end
end
