require 'spec_helper'

describe FumansController do
  before do
    @u = create(:user_nakaji)
    session[:user_id] = @u.id
  end

  context 'when user logged in' do

    describe "GET /fumans" do
      it "returns http success" do
        get 'index'
        expect(response).to be_success
      end
    end

    describe "GET /fumans/search" do
      it "returns http success" do
        get 'search'
        expect(response).to be_success
      end
    end

  end

end
