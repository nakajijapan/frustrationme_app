# coding: utf-8
require 'spec_helper'

describe 'Api::Items' do

  before do
    @u = create(:user_nakaji)
    @i = create(:item_amazon)
    @f = create(:fuman, {user_id: @u.id, item_id: @i.id})
    cookies[:auth_token] = @u.auth_token
  end

  describe '/api/items/1' do
    it 'returns http success' do
      get "/api/items/1"
      expect(response.status).to eq 200
    end

    it 'cat get title' do
      get "/api/items/1"
      data = JSON.parse(response.body)
      expect(data['item']['title']).to include 'マグカップ'
    end

    it 'cat get registered' do
      get "/api/items/1"
      data = JSON.parse(response.body)
      expect(data['registered']).to eq nil
    end
  end

end
