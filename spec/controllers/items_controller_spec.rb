require 'spec_helper'

describe ItemsController do

  before do
    @u = create(:user_nakaji)
    @i = create(:item_amazon)
    @f = create(:fuman, {user_id: @u.id, item_id: @i.id})
  end

  describe "GET 'show'" do
    it "returns http success" do
      visit "/items/#{@i.id}"
      expect(response).to be_success
    end
  end

end
