class Api::CategoriesController < Api::ApplicationController
  before_filter :require_user

  def index
    @categories = Category.where(user_id: @current_user.id)
    render json: {result: :OK, categories: @categories}
  end

  def show
    @category = Category.find(params[:id])
    render json: {result: :OK, category: @category}
  end

  def create
    @category = Category.new(category_params)

    if @category.save!
      render json: {result: :OK, category: @category}, status: :created
    end

  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes!(category_params)

    head :no_content
  end

  def destroy
    @category = Category.find(params[:id])
    @category.delete

    head :no_content
  end

  private
    def category_params
      params.require(:category).permit(:user_id, :name)
    end
end
