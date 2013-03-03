# coding: utf-8
class Fuman < ActiveRecord::Base
  attr_accessible :category_id, :content, :date, :item_id, :price, :priority, :status, :tag_ids, :title, :user_id

  STATUSES = {
    '1' => '欲している',
    '2' => '持っている',
    '3' => 'あげる',
    '4' => '体験した',
    '5' => '持っていた',
  }

  def self.status_options
    options = {}
    Fuman::STATUSES.map {|k, v| options[v] = k}
    options
  end

end
