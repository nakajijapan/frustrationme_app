require 'spec_helper'

describe 'Api::Categories' do
  before do
    @u = create(:user_nakaji)
    @my_key = 'd41d8cd98f00b204e9800998ecf8427e'
    @auth_str = "?my_user_id=#{@u.id}&my_key=#{@my_key}"
  end

  context 'when no login' do
    it '#index' do
      get "/api/me/categories.json"
      object = JSON.parser.new(response.body).parse()
      object['logined'].should == false
    end
  end

  it '#index' do
    get "/api/me/categories.json#{@auth_str}"
    response.status.should == 200
  end

  it '#create' do
    params = {category: {user_id: @u.id, name: 'hogehoge'}}
    post "/api/me/categories.json#{@auth_str}", params
    object = JSON.parser.new(response.body).parse()
    object['name'].should == 'hogehoge'
  end

  context 'when has data' do
    before do
      @c = create(:category, user_id: @u.id)
    end

    it '#show' do
      get "/api/me/categories/#{@c.id}.json#{@auth_str}"
      response.status.should == 200
    end

    it '#update' do
      params = {category: {name: 'monge'}}
      put "/api/me/categories/#{@c.id}.json#{@auth_str}", params
      response.status.should == 204
    end

    it '#destroy' do
      delete "/api/me/categories/1.json#{@auth_str}"
      response.status.should == 204
    end

  end

end
