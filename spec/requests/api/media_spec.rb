# coding: utf-8
require 'spec_helper'

describe 'Api::Media' do

  before do
    @u = create(:user_nakaji)
    5.times do
      @i = create(:item_amazon)
      create(:fuman, {user_id: @u.id, item_id: @i.id})
    end
  end

  describe '/api/top' do
    it 'returns http success' do
      get "/api/public_timeline"
      expect(response.status).to eq 200
    end

    it 'cat get title' do
      get "/api/public_timeline"
      data = JSON.parse(response.body)
      expect(data['items'][0]['title']).to include 'マグカップ'
    end

  end

end
