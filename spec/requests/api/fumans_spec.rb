# coding: utf-8
require 'spec_helper'

describe 'Api::Fumans' do

  describe '#statuses' do
    it 'returns http success' do
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
