require 'spec_helper'

describe SessionsController do

  describe "GET new" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe 'GET loggedin' do
    before do
      @u = create(:user_nakaji)
      session[:user_id] = @u.id
    end

    it 'returns http success' do
      params = {
        format: 'json',
      }
      get 'loggedin'
      expect(response).to be_success
    end

    it 'was logged in' do
      params = {
        format: 'json',
      }
      get 'loggedin'
      data = JSON.parse(response.body)
      expect(data['status']).to be_true
    end
  end

  describe 'DELETE destroy' do
    before do
      @u = create(:user_nakaji)
      session[:user_id] = @u.id
    end

    it 'redirect to root url' do
      delete 'destroy'
      expect(response).to redirect_to('/')
    end

    it 'was logged out' do
      delete 'destroy'
      expect(session[':user_id']).to be_nil
    end
  end

  describe "POST create" do
    before do
      create(:user_nakaji)
    end

    it "returns http success" do
        params = {
          username: 'daichi',
          password: 'hogehoge',
        }
      post 'create', params
      expect(response).to redirect_to('/users/daichi')
    end

    context 'when request invalid data' do
      it "render new" do
        params = {
          username: 'daichi',
          password: 'mogemoge',
        }
        post 'create', params
        expect(response).to render_template(:new)
      end
    end
  end

end
