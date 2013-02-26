class Api::CategoriesController < Api::ApplicationController

  def index
    @categories =  Category.find(
      :all, conditions: {user_id: @current_user.id}
    )
    respond_with @categories
  end

  def show
    @category = Category.find(params[:id])
    respond_with @category
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'created!'
    end

    respond_with @category, location: nil
  end

  def update
    logger.info params
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = 'updated!'
    end

    respond_with @category
  end

  def destroy
    @category = Category.find(params[:id])
    @category.delete

    respond_with @category, notice: 'deleted!'
  end

end
