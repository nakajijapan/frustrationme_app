require 'spec_helper'

describe Comment do

  context 'using scope' do
    before do
      @u = create(:user_nakaji)
      @u_h = create(:user_hamaji)

      @i = create(:item_amazon)
      @f = create(:fuman, {user_id: @u.id, item_id: @i.id})

      @i_f = create(:item_fuman)
      create(:fuman, {user_id: @u.id, item_id: @i_f.id})

      create(:comment, {user_id: @u.id,   item_id: @i.id})
      create(:comment, {user_id: @u_h.id, item_id: @i.id})
    end

    describe '#by_user' do
      it 'has 1 item' do
        expect(Comment.by_user(@u.id).length).to be 1
      end

      it 'has all item' do
        expect(Comment.by_user(nil).length).to be 2
      end
    end

    describe '#by_item' do
      it 'has 1 item' do
        expect(Comment.by_item(@i.id).length).to be 2
      end

      it 'has all item' do
        expect(Comment.by_item(nil).length).to be 2
      end
    end
  end
end
