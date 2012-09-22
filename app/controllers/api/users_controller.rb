class Api::UsersController < ApplicationController
  def show
    respond_to do |format|
      format.json {render :json => 'hogehogehoge'}
    end
  end
end
