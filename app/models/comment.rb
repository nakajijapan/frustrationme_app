# coding: utf-8
class Comment < ActiveRecord::Base
  attr_accessible :user_id, :item_id, :text

  belongs_to :user

  scope :by_user, lambda { |name| where('user_id = ?', name) if name.present? }
  scope :by_item, lambda { |name| where('item_id = ?', name) if name.present? }

  def self.timeline(params, per=50)
    Comment.by_user(params[:user_id])
    .by_item(params[:item_id])
    .page(params[:page]).per(per)
  end

end
