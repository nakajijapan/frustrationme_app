require 'spec_helper'

describe SessionsController do
  before do
    @u = create(:user_nakaji)
    session[:user_id] = @u.id
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe '#loggedin' do
    it 'returns http success' do
      params = {
        format: 'json',
      }
      get 'loggedin'
      expect(response).to be_success
    end

    it 'was logged in' do
      params = {
        format: 'json',
      }
      get 'loggedin'
      data = JSON.parse(response.body)
      expect(data['status']).to be_true
    end
  end
end
