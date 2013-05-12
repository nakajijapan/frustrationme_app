# coding: utf-8
require 'spec_helper'

describe 'Api::Fumans' do
  before do
    @u = create(:user_nakaji)
    @my_key = 'd41d8cd98f00b204e9800998ecf8427e'
    @auth_str = "?my_user_id=#{@u.id}&my_key=#{@my_key}"
  end

  describe '#statuses' do
    it 'return 200' do
      get "/api/fumans/statuses.json"
      expect(response.status).to eq 200
    end

    it 'get json data' do
      get "/api/fumans/statuses.json"
      data = JSON.parse(response.body)
      expect(data['1']).to eq '欲しい'
    end
  end

end
