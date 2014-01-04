# coding: utf-8
require 'spec_helper'

describe ApplicationController do

  describe 'GET /hogehoge' do

    it 'returns 404' do
      get '/hogehoge'
      expect(response.status).to eq 404
    end

  end

end
