class Api::CategoriesController < Api::ApplicationController

  def index
    @categories = Category.where(user_id: @current_user.id).first
    respond_with @categories
  end

  def show
    @category = Category.find(params[:id])
    respond_with @category
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'created!'
    end

    respond_with @category, location: nil
  end

  def update
    logger.info params
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice] = 'updated!'
    end

    respond_with @category
  end

  def destroy
    @category = Category.find(params[:id])
    @category.delete

    respond_with @category, notice: 'deleted!'
  end

  private
    def category_params
      params.require(:category).permit(:user_id, :name)
    end
end
