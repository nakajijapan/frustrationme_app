class Friendship < ActiveRecord::Base
  has_many :users
  belongs_to :user

  accepts_nested_attributes_for :users

  def following_user
    User.find(self.following_id)
  end
end
