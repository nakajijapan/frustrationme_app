require 'spec_helper'

describe 'Api::Categories' do
  before do
    @u = create(:user_nakaji)
    @token = @u.token
    @auth_str = "?user_id=#{@u.id}&token=#{@token}"
  end

  context 'when no login' do
    it '#index' do
      get "/api/me/categories.json"
      data = JSON.parser.new(response.body).parse()
      expect(data['message']).to eq 'logged out'
    end
  end

  it '#index' do
    get "/api/me/categories.json#{@auth_str}"
    expect(response.status).to eq 200
  end

  it '#create' do
    params = {category: {user_id: @u.id, name: 'hogehoge'}}
    post "/api/me/categories.json#{@auth_str}", params
    data = JSON.parser.new(response.body).parse()
    expect(data['name']).to eq 'hogehoge'
  end

  context 'when has data' do
    before do
      @c = create(:category, user_id: @u.id)
    end

    it '#show' do
      get "/api/me/categories/#{@c.id}.json#{@auth_str}"
      expect(response.status).to eq 200
    end

    it '#update' do
      params = {category: {name: 'monge'}}
      put "/api/me/categories/#{@c.id}.json#{@auth_str}", params
      expect(response.status).to eq 204
    end

    it '#destroy' do
      delete "/api/me/categories/1.json#{@auth_str}"
      expect(response.status).to eq 204
    end
  end
end
