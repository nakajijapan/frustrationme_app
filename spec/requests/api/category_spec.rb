require 'spec_helper'

describe 'Api::Categories' do
  before do
    @u = create(:user_nakaji)
  end

  context 'when not log in' do
    it '#index' do
      get "/api/me/categories"
      data = JSON.parser.new(response.body).parse()
      expect(data['result']).to eq 'NG'
      expect(data['message']).to eq 'auth error'
    end
  end

  context 'when logged in' do
    before do
      3.times { create(:category, user_id: @u.id) }
      cookies[:auth_token] = @u.auth_token
    end

    it '#index' do
      get "/api/me/categories"
      expect(response.status).to eq 200
    end

    it '#create' do
      params = {category: {user_id: @u.id, name: 'hogehoge'}}
      post "/api/me/categories", params
      data = JSON.parser.new(response.body).parse()
      expect(data['category']['name']).to eq 'hogehoge'
    end

    before do
      @c = create(:category, user_id: @u.id)
    end

    it '#show' do
      get "/api/me/categories/#{@c.id}"
      expect(response.status).to eq 200
    end

    it '#update' do
      params = {category: {name: 'monge'}}
      put "/api/me/categories/#{@c.id}", params
      expect(response.status).to eq 204
    end

    it '#destroy' do
      delete "/api/me/categories/1"
      expect(response.status).to eq 204
    end
  end
end
