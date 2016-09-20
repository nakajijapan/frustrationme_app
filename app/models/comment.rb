# coding: utf-8
class Comment < ActiveRecord::Base
  belongs_to :user

  scope :by_user, lambda { |name| where('user_id = ?', name) if name.present? }
  scope :by_item, lambda { |name| where('item_id = ?', name) if name.present? }

  after_create :save_activity_after_create

  def self.timeline(params, per=50)
    Comment.by_user(params[:user_id])
    .by_item(params[:item_id])
    .page(params[:page]).per(per)
  end

  def save_activity_after_create
    params = {
      user_id: self.user_id,
      item_id: self.item_id,
      event_type: :create,
      message: 'へのコメントが登録されました',
    }
    Activity.new(params).save
  end

end
