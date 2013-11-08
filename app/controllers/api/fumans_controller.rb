class Api::FumansController < Api::ApplicationController
  def statuses
    respond_with Fuman::STATUSES
  end
end
