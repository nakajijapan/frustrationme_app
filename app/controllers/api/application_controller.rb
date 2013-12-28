require 'active_record/validations'

class Api::ApplicationController < ActionController::Base

  respond_to :json
  before_filter :require_user

  # 404
  def render_not_found
    render json: {result: :NG, message: 'page not found'}, status: :not_found
  end

  def render_success(msg)
    render json: {result: :OK, message: msg}, status: 200
  end

  def require_user
    return if signed_in?
    render json: {result: :NG, message: 'auth error'}
  end

  def sign_in(user)
    user.auth_token = cookies[:auth_token] = User.new_auth_token
    user.update_attribute(:auth_token, user.auth_token)
    current_user = user
  end

  def signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token])
  end

  def current_user=(user)
    @current_user = user
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    respond_with_error(exception, 422, error: exception.record.errors.messages)
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_with_error(exception, 404, error: exception.message)
  end

  private
  def respond_with_error(exception, code, errors={})
    render json: {
      result: :NG,
      status_code: code,
      error: exception.class.to_s,
      message: exception.to_s,
      errors: errors,
      },
      status: code
  end

end
