require 'spec_helper'

describe PasswordController do

  before do
    @u = create(:user_nakaji)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe 'POST sendmail' do
    it "returns http success" do
      params = {
        user: {
          username: 'daichi',
          email: 'hogehoge@majide.com',
        }
      }
      post 'sendmail', params
      expect(response).to be_success
    end

    it "returns error" do
      params = {
        user: {
          username: 'daichi',
          email: 'test@test.com',
        }
      }
      post 'sendmail', params
      expect(response).to render_template('index')
    end
  end

  describe 'GET reset' do
    it "returns http success" do
      @u.mode = :social
      @u.update_attributes(reset_hash: 'hogehoge')
      get 'reset', {reset_hash: 'hogehoge'}
      expect(response).to be_success
    end

    it "returns 404" do
      get 'reset', {reset_hash: 'hogehoge'}
      expect(response.code).to eq '404'
    end
  end

  describe 'POST finish' do
    it "returns http success" do
      @u.mode = :social
      @u.update_attributes reset_hash: 'hogehoge'
      params = {
        reset_hash: 'hogehoge',
        user: {
          password: 'hogehogehoge',
          password_confirmation: 'hogehogehoge',
        }
      }
      post 'finish', params
      expect(response).to be_success
    end

    context 'when request no parameter' do
      it "returns 404" do
        post 'finish', {reset_hash: 'hogehoge'}
        expect(response.code).to eq '404'
      end
    end

    context 'when not has reset_hash' do
      it "returns 404" do
        post 'finish', {}
        expect(response.code).to eq '404'
      end
    end

  end
end
