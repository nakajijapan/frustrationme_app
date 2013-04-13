# coding: utf-8
class Comment < ActiveRecord::Base
  attr_accessible :user_id, :item_id, :text

  belongs_to :user
end
