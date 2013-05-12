class Api::FumansController < ApplicationController
  def statuses
    respond_with Fuman::STATUSES
  end
end
