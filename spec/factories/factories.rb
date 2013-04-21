# -*- coding: utf-8 -*-

FactoryGirl.define do
  factory :user_nakaji, :class => User do
     username 'daichi'
     password 'hogehoge'
     email 'hogehoge@majide.com'
     sex 1
   end

  factory :user_hamaji, :class => User do
     username 'hamaji'
     password 'hogehoge'
     email 'hogehoge@majide.com'
     sex 1
   end

  factory :category, :class => Category do
     user_id nil
     name 'hogehoge_name'
   end

  factory :item_amazon, class: Item do
    service_code 0
    product_id   'B000J4P83G'
    url          'http://www.amazon.co.jp/Amazon%E5%95%86%E4%BA%8B-Amazon%E3%82%AA%E3%83%AA%E3%82%B8%E3%83%8A%E3%83%AB%E3%83%9E%E3%82%B0%E3%82%AB%E3%83%83%E3%83%97%E9%BB%92/dp/B000J4P83G%3FSubscriptionId%3DAKIAIVV7Y23EERRWHURQ%26tag%3Ddaichibnejp-22%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB000J4P83G'
    preview_url  ''
    title        'Amazonオリジナルマグカップ'
    description  ''
    release_date '2006-11-01 00:00:00'
    image_s      "http://ecx.images-amazon.com/images/I/41WKdjaRR3L.jpg"
    image_m      "http://ecx.images-amazon.com/images/I/41WKdjaRR3L.jpg"
    image_l      "http://ecx.images-amazon.com/images/I/41WKdjaRR3L.jpg"
    is_adult     false
    price        0
   end

  factory :fuman, class: Fuman do
    status 1
    category_id nil
   end

  factory :comment, class: Comment do
    user_id nil
    item_id nil
    text 'moge'
  end
end
