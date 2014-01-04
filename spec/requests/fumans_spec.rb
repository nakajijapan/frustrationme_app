# coding: utf-8
require 'spec_helper'

describe FumansController do

  describe 'GET /fumans/categories/:type' do

    %w(amazon yahooauction rakuten itunes).each do |type|

      context "when type is #{type}" do

        before do
          get "/fumans/categories/#{type}.json"
        end

        it 'returns http success' do
          expect(response.status).to eq 200
        end

        it 'data retured is hash' do
          data = JSON.parse(response.body)
          expect(data.count).to be > 1
        end

      end

    end

  end

end
