require 'spec_helper'

describe CategoriesController do
  before do
    @u = create(:user_nakaji)
    @i = create(:item_amazon)
    @f = create(:fuman, {user_id: @u.id, item_id: @i.id})
    @c = create(:category, {user_id: @u.id})
    session[:user_id] = @u.id
  end

  describe "GET index" do
    it "returns http success(json)" do
      params = {
        format: 'json'
      }
      get 'index', params
      response.should be_success
    end

    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST create" do
    it "returns http success" do
      params = {
        format: 'json',
        category: {
          name: 'hogehoge'
        }
      }
      post 'create', params
      response.should be_success
    end
  end

  describe "PUT update" do
    it "returns http success" do
      category = create(:category, user_id: @u.id, name: 'hogehoge')

      params = {
        format: 'json',
        id: category.id,
        category: {
          name: 'mogemoge'
        }
      }

      put 'update', params
      response.should be_success
    end
  end

  describe "DELETE destroy" do
    it "returns http success" do
      category = create(:category, user_id: @u.id, name: 'hogehoge')

      params = {
        format: 'json',
        id: category.id,
      }

      delete 'destroy', params
      response.should be_success
    end
  end
end
