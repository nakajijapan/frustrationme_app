class Api::SessionsController < Api::ApplicationController
  skip_filter :require_user

  def create
    @user = User.find_by_username_and_crypted_password(
      params[:username],
      Digest::MD5.hexdigest(params[:password])
    )

    if @user.present?
      sign_in(@user)
      render json: {result: :OK }, status: :created
    else
      render json: {result: :NG, message: 'Validation failed' }, status: :unprocessable_entity
    end
  end

end
