class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save

    respond_with @user, :location => root_url, :notice => 'created!'
  end

end
