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

  describe 'GET /api/fumans/search' do

    context 'when service_name is invalid' do
      before do
        get '/api/fumans/search'
      end

      it 'returns 422' do
        expect(response.status).to eq 422
      end

      it 'get message' do
        data = JSON.parse(response.body)
        expect(data['message']).to include 'service_name is required'
      end

    end

    context 'when category is invalid' do
      before do
        params = {service_name: 'amazon'}
        get '/api/fumans/search', params
      end

      it 'returns 422' do
        expect(response.status).to eq 422
      end

      it 'get message' do
        data = JSON.parse(response.body)
        expect(data['message']).to include 'category is required'
      end

    end

  end

end
