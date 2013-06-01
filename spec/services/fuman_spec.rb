require 'spec_helper'

describe 'ServiceFuman' do
  before do
    @u = create(:user_nakaji)

    @p_item = {
      service_code: 0,
      product_id: 'B000J4P83G'
    }
    @p_fuman = {
      status: '2',
      category_id: nil,
    }
  end

  context 'when not registe item' do

    describe '#create_with_item' do
      before do
        item = double('ApiBucket::Amazon::Item', {
          service_code: 0,
          product_id:   'B000J4P83G',
          detail_url:   'http://www.amazon.co.jp/Amazon%E5%95%86%E4%BA%8B-Amazon%E3%82%AA%E3%83%AA%E3%82%B8%E3%83%8A%E3%83%AB%E3%83%9E%E3%82%B0%E3%82%AB%E3%83%83%E3%83%97%E9%BB%92/dp/B000J4P83G%3FSubscriptionId%3DAKIAIVV7Y23EERRWHURQ%26tag%3Ddaichibnejp-22%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB000J4P83G',
          preview_url:  '',
          title:        'Amazonオリジナルマグカップ',
          description:  '',
          release_date: '2006-11-01 00:00:00',
          image: {
            l: {
              url: "http://ecx.images-amazon.com/images/I/41WKdjaRR3L.jpg"
            }
          },
          price:        0,
        })
        service = double('service')
        service.stub(:lookup).and_return(item)
        @service_fuman = ServiceFuman.new(@u)
        @service_fuman.service = service
      end

      it "can create item" do
        saved = @service_fuman.create_with_item(@p_item, @p_fuman)
        expect(saved).to be_true
      end

      it "change fuman.status" do
        @service_fuman.create_with_item(@p_item, @p_fuman)
        expect(@service_fuman.fuman.status).to eq 2
      end
    end

    describe '#create_with_item_using_frustration' do
      it "return true" do
        service_fuman = ServiceFuman.new(@u)
        p_item = {
          service_code: 5,
          title: 'title',
          url: 'http://hogehoge.com',
          image_l: 'http://hogehoge.com/hoge.jpg',
        }
        saved = service_fuman.create_with_item_using_frustration(p_item, @p_fuman)
        expect(saved).to be_true
      end
    end
  end

  context 'when already registed item' do
    before do
      @i = create(:item_amazon)
      @f = create(:fuman, {user_id: @u.id, item_id: @i.id})
    end

    describe '#create_with_item' do
      it "return true" do
        service_fuman = ServiceFuman.new(@u)
        saved = service_fuman.create_with_item(@p_item, @p_fuman)
        expect(saved).to be_true
      end

      it "has one item" do
        service_fuman = ServiceFuman.new(@u)
        service_fuman.create_with_item(@p_item, @p_fuman)
        expect(Item.all.count).to eq 1
      end

      it "does not change fuman.status" do
        service_fuman = ServiceFuman.new(@u)
        service_fuman.create_with_item(@p_item, @p_fuman)
        expect(service_fuman.fuman.status).to eq 1
      end
    end
  end

end
