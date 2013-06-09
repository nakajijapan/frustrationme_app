require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET show" do
    before do
      @u = create(:user_nakaji)
      @i = create(:item_amazon)
      @f = create(:fuman, {user_id: @u.id, item_id: @i.id})
    end

    it "returns http success" do
      params = {
        username: 'daichi'
      }
      get 'show', params
      response.should be_success
    end
  end

  describe "POST create" do
    it "returns http success" do
        params = {
          user: {
            username:              'daichi',
            email:                 'hoge@hoge.com',
            password:              'hogehoge',
            password_confirmation: 'hogehoge'
          }
        }
      post 'create', params
      expect(response).to redirect_to('/login')
    end

    context 'when request invalid data' do
      it "render new" do
        params = {
          user: {
            username:              'daichi',
            email:                 '',
            password:              'hogehoge',
            password_confirmation: 'hogehoge'
          }
        }
        post 'create', params
        expect(response).to render_template(:new)
      end
    end
  end
end
