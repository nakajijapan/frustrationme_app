require 'spec_helper'

describe 'Api::Followers' do
  before do
    @u_target = create(:user_hamaji)
    @u = create(:user_nakaji)

    Friendship.new({user_id: @u.id, following_id: @u_target.id}).save
    Friendship.new({user_id: @u_target.id, following_id: @u.id}).save
  end

  describe "GET /api/users/1/followers" do
    it "returns http success" do
      get '/api/users/1/followers'
      expect(response).to be_success
    end

    it "get user data" do
      get '/api/users/1/followers'
      data = JSON.parse(response.body)
      expect(data['users'][0]['username']).to eq 'daichi'
    end
  end

end
