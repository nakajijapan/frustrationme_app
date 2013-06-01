class SettingsController < ApplicationController
  before_filter :current_user

  def profile
    @user = @current_user
  end

  def profile_update
    @user = @current_user
    @user.mode = :social
    saved = @user.update_attributes(params[:user])

    respond_to do |format|
      if saved
        flash[:notice] = 'created!!'
        format.html { redirect_to action: 'profile' }
        format.json { render json: '', status: :created, location: @user }
      else
        format.html { render action: 'profile' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
