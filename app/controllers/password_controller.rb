class PasswordController < ApplicationController
  def index
    @user = User.new
  end

  def sendmail
    @user = User.where(username: params[:user][:username])
                .where(email: params[:user][:email])
                .first

    if @user.nil?
      @user = User.new
      @user.errors.add(:base, 'Please Input')
      saved = false
    else
      hash = Digest::MD5.hexdigest("%x" % (Time.now.to_i + rand(65535)))
      @user.mode = :social
      saved = @user.update_attributes({reset_hash: hash})
      UserMailer.reset_password(@user).deliver if saved
    end

    respond_to do |format|
      if saved
        format.html
      else
        format.html { render action: 'index' }
      end
    end
  end

  def reset
    @user = User.find_by_reset_hash(params[:reset_hash])
    return render_not_found if @user.nil?
  end

  def finish
    return render_not_found if params[:reset_hash].blank?

    @user = User.find_by_reset_hash(params[:reset_hash])
    return render_not_found if @user.nil?

    params[:user][:reset_hash] = ''
    saved = @user.update_attributes(user_params)

    respond_to do |format|
      if saved
        format.html
      else
        format.html { render action: 'reset' }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
