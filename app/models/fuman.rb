# coding: utf-8
class Fuman < ActiveRecord::Base
  self.table_name = 'fumans'
  attr_accessible :user_id, :content, :category_id, :item_id, :status, :tag_ids

  belongs_to :user
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

  def comments_of_user
    Comment.where('user_id = ?', self.user_id).where('item_id = ?', self.item_id).order('created_at desc')
  end
end
