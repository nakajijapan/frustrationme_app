require 'spec_helper'

describe Fuman do

  before do
    @u = create(:user_nakaji)
    @u_h = create(:user_hamaji)

    @i = create(:item_amazon)
    @f = create(:fuman, {user_id: @u.id, item_id: @i.id})

  end


  describe 'creates item' do

    it 'created activity' do
      expect(Activity.all.count).to eq 1
    end

    it 'equal create to activity.event_type' do
     expect(Activity.order(:created_at)[0].event_type).to eq 'create'
    end

  end

  describe 'update item' do

    before do
      @f.status = 2
      @f.save
    end

    it 'created activity' do
     expect(Activity.all.count).to eq 2
    end

    it 'equal update to activity.event_type' do
     expect(Activity.order(:created_at)[1].event_type).to eq 'update'
    end

  end

  describe 'destroy item' do

    before do
      @f.destroy
    end

    it 'created activity' do
      expect(Activity.all.count).to eq 2
    end

    it 'equal destroy to activity.event_type' do
      expect(Activity.order(:created_at)[1].event_type).to eq 'destroy'
    end


  end


end
