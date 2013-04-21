require 'spec_helper'

describe FriendshipsController do

  before do
    @u_target = create(:user_hamaji)
    @u = create(:user_nakaji)

    session[:user_id] = @u.id
  end

  context "POST /friendships/" do
    it "returns http success" do
      params = {
        format: 'json',
        id: @u_target.id
      }
      post 'create', params
      expect(response).to be_success
    end

    it "returns 500 error (duplication registration)" do
      Friendship.new({user_id: @u.id, following_id: @u_target.id}).save
      params = {
        format: 'json',
        id: @u_target.id
      }
      post 'create', params
      expect(response.code).to eq '200'
    end

    it "returns not_found" do
      params = {
        format: 'json',
        id: 9999
      }
      post 'create', params
      expect(response.code).to eq '404'
    end
  end

  context "DELETE /friendships/" do
    it "returns http success" do
      Friendship.new({user_id: @u.id, following_id: @u_target.id}).save

      params = {
        format: 'json',
        id: @u_target.id
      }
      delete 'destroy', params
      expect(response).to be_success
    end

    it "returns not_found" do
      params = {
        format: 'json',
        id: 9999
      }
      delete 'destroy', params
      expect(response.code).to eq '404'
    end
  end

  context "GET following" do
    it "returns http success" do
      Friendship.new({user_id: @u.id, following_id: @u_target.id}).save
      Friendship.new({user_id: @u_target.id, following_id: @u.id}).save
      params = {
        username: @u.username
      }
      get 'followings', params
      expect(response).to be_success
    end
  end

  context "GET followers" do
    it "returns http success" do
      Friendship.new({user_id: @u.id, following_id: @u_target.id}).save
      Friendship.new({user_id: @u_target.id, following_id: @u.id}).save
      params = {
        username: @u.username
      }
      get 'followers', params
      expect(response).to be_success
    end
  end

end
