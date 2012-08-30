class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    reset_session

    @user = User.find_by_username_and_crypted_password(params[:username], Digest::MD5.hexdigest(params[:password]))

    if @user
      session[:user_id] = @user.id
      redirect_to '/home', :notice => 'Login successful.'
    else
      flash.now[:alert] = "Login failed."; render :action => "new"
    end
  end

  def destroy
    reset_session
    redirect_to :root, :notice => 'Logged out!'
  end
end
