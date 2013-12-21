# coding: utf-8
require 'spec_helper'

describe 'Api::Users' do

  before do
    @u = create(:user_nakaji)
    @i = create(:item_amazon)
    @f = create(:fuman, {user_id: @u.id, item_id: @i.id})

    @u_target = create(:user_hamaji)
    @f_target = create(:fuman, {user_id: @u_target.id, item_id: @i.id})

    Friendship.new({user_id: @u.id, following_id: @u_target.id}).save
  end

  describe 'GET /api/users/1/user_timeline' do
    it 'returns ok' do
      get "/api/users/#{@u.id}/user_timeline"
      expect(response.status).to eq 200
    end

    it 'can get friends data' do
      get "/api/users/#{@u.id}/user_timeline"
      data = JSON.parse(response.body)
      expect(data['items'][0]['title']).to include 'マグカップ'
    end
  end

  describe 'GET /api/users/1/friends_timeline' do
    it 'returns ok' do
      get "/api/users/#{@u.id}/friends_timeline"
      expect(response.status).to eq 200
    end

    it 'can get friends data' do
      get "/api/users/#{@u.id}/friends_timeline"
      data = JSON.parse(response.body)
      expect(data['items'][0]['title']).to include 'マグカップ'
      expect(data['items'][0]['fuman']['user']['username']).to eq 'hamaji'
    end
  end

  describe "POST /api/user" do

    context 'when post data is valid' do
      before do
        @params = {
          user: {
            username:              'daichi2',
            email:                 'hoge@hoge.com',
            password:              'hogehoge',
            password_confirmation: 'hogehoge'
          }
        }
      end

      it "returns created" do
        post "/api/users", @params
        expect(response.status).to eq 201
      end

      it "return result" do
        post "/api/users", @params
        data = JSON.parse(response.body)
        expect(data['result']).to eq 'OK'
      end
    end

    context 'when post data is valid' do
      before do
        @params = {
          user: {
            username:              'daichi3',
            email:                 'hoge@hoge.com',
          }
        }
      end

      it "returns unprocessable entity" do
        post "/api/users", @params
        expect(response.status).to eq 422
      end

      it "returns result" do
        post "/api/users", @params
        data = JSON.parse(response.body)
        expect(data['result']).to eq 'NG'
      end
    end

  end

end
