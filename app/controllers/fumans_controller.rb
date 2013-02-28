class FumansController < ApplicationController
  def search

  end

  def create
  end

  def categories
    @categories = ApiBucket::Service.instance(:"#{params[:type]}").categories rescue(return render_not_found)
    respond_with @categories
  end
end
