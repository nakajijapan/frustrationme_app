class Api::ApplicationController < ActionController::Base
  respond_to :html, :json

  before_filter :require_user

  # 404
  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end

  # [params]
  #   my_user_id
  #   my_key
  def require_user
    @current_user = User.find_by_id(params[:my_user_id])

    logger.info __LINE__
    logger.info "require_logincheck_api"

    # user check
    if @current_user
      logger.info(__LINE__)
      logger.debug(params[:my_key])
      logger.debug(@current_user.id.to_s + @current_user.crypted_password.to_s)
      logger.debug(@current_user.get_hash)

      hash = @current_user.get_hash

      logger.debug hash
      logger.warn "--------------------------"

      # key check
      if params[:my_key] != nil

        logger.warn "my_key = #{params[:my_key]}"

        if hash === params[:my_key]

          logger.warn "my_key = hash"

          return true
        end
      end
    end

    #render :json => {:logined => false}
    respond_to do |format|
      format.json {render :json => {:logined => false}}
    end
  end
end
