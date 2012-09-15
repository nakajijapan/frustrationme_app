require 'spec_helper'

describe FumansController do

  describe "GET 'search'" do
    it "returns http success" do
      get 'search'
      response.should be_success
    end
  end

end
