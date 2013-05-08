class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #raise request.env["omniauth.auth"].to_yaml
    reset_session

    auth = request.env["omniauth.auth"]
    if auth.present?
      @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      @user = User.create_with_omniauth(auth) if @user.nil?
    else
      @user = User.find_by_username_and_crypted_password(params[:username], Digest::MD5.hexdigest(params[:password]))
    end

    if @user
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.username}", :notice => 'Login successful.'
    else
      flash.now[:alert] = "Login failed."; render :action => "new"
    end
  end

  def destroy
    reset_session
    redirect_to '/', :notice => 'Logged out!'
  end
end
