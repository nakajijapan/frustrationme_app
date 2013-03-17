require 'spec_helper'

describe CommentsController do
  before do
    @u = create(:user_nakaji)
    @i = create(:item_amazon)
    @f = create(:fuman, {user_id: @u.id, item_id: @i.id})
    session[:user_id] = @u.id
  end

  describe "GET index" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST create" do
    it "returns http success" do
      params = {
        format: 'json',
        comment: {
          item_id: @i.id,
          text: 'hogehoge'
        }
      }
      post 'create', params
      response.should be_success
    end
  end

  describe "PUT update" do
    it "returns http success" do
      comment = create(:comment, user_id: @u.id, item_id: @i.id, text: 'hogehoge')

      params = {
        format: 'json',
        id: comment.id,
        comment: {
          item_id: @i.id,
          text: 'mogemoge'
        }
      }

      put 'update', params
      response.should be_success
    end
  end

  describe "DELETE destroy" do
    it "returns http success" do
      comment = create(:comment, user_id: @u.id, item_id: @i.id, text: 'hogehoge')

      params = {
        format: 'json',
        id: comment.id,
      }

      delete 'destroy', params
      response.should be_success
    end
  end
end
