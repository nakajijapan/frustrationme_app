# -*- coding: utf-8 -*-

FactoryGirl.define do
  factory :user_nakaji, :class => User do
     username 'daichi'
     password 'hogehoge'
     email 'hogehoge@majide.com'
     sex 1
   end

  factory :category, :class => Category do
     name 'hogehoge_name'
   end
end
