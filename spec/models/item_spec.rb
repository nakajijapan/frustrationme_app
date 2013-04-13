require 'spec_helper'

describe Item do

  context 'has registed Item' do
    before do
      @u = create(:user_nakaji)
      @i = create(:item_amazon)
      @f = create(:fuman, {user_id: @u.id, item_id: @i.id})
      @c = create(:comment, {user_id: @u.id, item_id: @i.id})
    end

    describe '#fumans_with_status' do
      it 'has 1 item' do
        item = Item.find(@i.id)
        expect(item.users_with_status(1).count).to eq 1
      end

      it 'has User Class' do
        item = Item.find(@i.id)
        expect(item.users_with_status(1).first.class).to eq User
      end

      it 'has user info' do
        item = Item.find(@i.id)
        expect(item.users_with_status(1).first.username).to eq 'daichi'
      end
    end

    describe '#comment_list' do
      it 'has 1 comment' do
        item = Item.find(@i.id)
        expect(item.comment_list.count).to eq 1
      end

      it 'has Comment Class' do
        item = Item.find(@i.id)
        expect(item.comment_list.first.class).to eq Comment
      end
    end
  end
end
