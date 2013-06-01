require 'spec_helper'

describe SettingsController do
  before do
    @u = create(:user_nakaji)
    session[:user_id] = @u.id
  end

  describe "GET profile" do
    it "returns http success" do
      get 'profile'
      expect(response).to be_success
    end
  end

  describe "POST profile_update" do
    it "returns http success" do
      params = {
        user: {
          message: 'this is message...'
        }
      }
      put 'profile_update', params
      expect(response).to redirect_to('/settings/profile')
    end

    context 'when request invalid data' do
      it "render profile" do
        params = {
          user: {
            email: 'invalid_mail'
          }
        }
        put 'profile_update', params
        expect(response).to render_template(:profile)
      end
    end
  end
end
