# coding: utf-8
class Fuman < ActiveRecord::Base
  self.table_name = 'fumans'

  belongs_to :user
  has_one :item
  #has_one :friendship, conditions: proc { 'fuman.user_id = friendship.following_id' }
  has_one :friendship, primary_key: :user_id, foreign_key: :following_id

  before_save :set_default

  after_create :save_activity_after_create
  after_update :save_activity_after_update
  after_destroy :save_activity_after_destroy

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

  def save_activity_after_create
    params = {
      user_id: self.user_id,
      item_id: self.item_id,
      event_type: :create,
      message: 'が登録されました',
    }
    Activity.new(params).save
  end

  def save_activity_after_update
    if self.status_changed?
      params = {
        user_id: self.user_id,
        item_id: self.item_id,
        event_type: :update,
        message: "のステータスが「#{STATUSES[self.status]}」に変更されました",
      }
      Activity.new(params).save
    end
  end

  def save_activity_after_destroy
    params = {
      user_id: self.user_id,
      item_id: self.item_id,
      event_type: :destroy,
      message: 'が削除されました',
    }
    Activity.new(params).save
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
