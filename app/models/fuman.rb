# coding: utf-8
class Fuman < ActiveRecord::Base
  self.table_name = 'fumans'
  attr_accessible :user_id, :content, :category_id, :item_id, :status, :tag_ids

  has_one :item

  STATUSES = {
    '1' => '欲しい',
    '2' => '持ってる',
    '3' => 'あげたい',
    '4' => '体験した',
    '5' => '持っていた',
  }

  def self.status_options
    options = {}
    Fuman::STATUSES.map {|k, v| options[v] = k}
    options
  end

end
