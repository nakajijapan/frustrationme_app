# coding: utf-8
class Fuman < ActiveRecord::Base
  self.table_name = 'fumans'

  belongs_to :user
  has_one :item

  before_save :set_default

  STATUSES = {
    '1' => '欲しい',
    '2' => '持ってる',
    '3' => 'あげたい',
    '4' => '体験した',
    '5' => '持っていた',
  }

  validates :status,
    inclusion: {in: [1, 2, 3, 4, 5], if: :status}

  def set_default
    self.status = 1 if self.status.blank?
  end

  def self.status_options
    options = {}
    Fuman::STATUSES.map {|k, v| options[v] = k}
    options
  end

  def comments_of_user
    Comment.where('user_id = ?', self.user_id).where('item_id = ?', self.item_id).order('created_at desc')
  end
end
