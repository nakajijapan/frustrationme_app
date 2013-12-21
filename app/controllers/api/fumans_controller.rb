class Api::FumansController < Api::ApplicationController
  skip_filter :require_user

  def statuses
    respond_with Fuman::STATUSES
  end
end
