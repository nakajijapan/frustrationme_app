class Friendship < ActiveRecord::Base
  attr_accessible :following_id, :user_id

  has_many :users
  belongs_to :user

  accepts_nested_attributes_for :users
end
