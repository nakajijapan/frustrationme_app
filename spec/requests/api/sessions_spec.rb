# coding: utf-8
require 'spec_helper'

describe 'Api::Sessions' do
  describe 'CREATE /api/sessions' do
    before do
      @u = create(:user_nakaji)
    end

    context 'valid data' do
      before do
        @params = {
          username: 'daichi',
          password: 'hogehoge'
        }
        post "/api/sessions", @params
      end

      it 'returns http success' do
        expect(response.status).to eq 201
      end

      it 'returns cookie for auth_token' do
        expect(cookies['auth_token']).to eq User.find(@u.id).auth_token
      end
    end

    context 'invalid data' do
      before do
        @params = {
          username: 'daichi',
          password: ''
        }
        post "/api/sessions", @params
      end

      it 'returns unprocessable entity' do
        expect(response.status).to eq 422
      end

      it 'can get error message' do
        data = JSON.parse(response.body)
        expect(data['message']).to include 'Validation failed'
      end
    end

  end
end