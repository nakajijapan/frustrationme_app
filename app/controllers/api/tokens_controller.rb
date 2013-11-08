class Api::TokensController < Api::ApplicationController
  skip_filter :require_user

  # POST /api/tokens/
  def create
    params[:username] = '' if params[:username].nil?
    params[:password] = '' if params[:password].nil?

    @user = User.find_by_username_and_crypted_password(params[:username], Digest::MD5.hexdigest(params[:password]))

    if @user
      render json: {token: @user.token, user: @user}
    else
      render json: {token: '', message: 'no data'}, status: :unprocessable_entity
    end
  end
end
