# coding: utf-8
require 'spec_helper'

describe 'Api::TokensController' do
  before do
    @u = create(:user_nakaji)
  end

  describe 'POST /api/tokens' do
    context 'when success' do
      it 'returns http success' do
        params = {username: @u.username, password: 'hogehoge'}
        post '/api/tokens.json', params
        expect(response.status).to eq 200
      end

      it 'get json data' do
        params = {username: @u.username, password: 'hogehoge'}
        post '/api/tokens.json', params
        data = JSON.parse(response.body)
        expect(data['token'].length).to be > 0
      end
    end

    context 'when failed' do
      it 'returns http failed' do
        post '/api/tokens.json'
        expect(response.status).to eq 422
      end

      it 'get json data' do
        post '/api/tokens.json'
        data = JSON.parse(response.body)
        expect(data['message']).to eq 'no data'
      end
    end
  end
end
