class Frendship < ActiveRecord::Base
  attr_accessible :following_id, :user_id

  #self.primary_key = :id
  has_many :users
  belongs_to :user

  accepts_nested_attributes_for :users

  #-----------------------------------------------------------------------------
  # followers
  #-----------------------------------------------------------------------------
  def self.followers(user_id, page, limit=10)
    Friendship.select("friendships.*, users.username")
      .joins("inner join users on friendships.following_id = users.id")
      .where("following_id = ?", user_id)
      .order("friendships.created_at desc")
      .page(page)
      .per(limit)
  end

  #-----------------------------------------------------------------------------
  # followings
  #-----------------------------------------------------------------------------
  def self.followings(user_id, page, limit=10)
    Friendship.select("friendships.*, users.username")
    .joins(:user)
    .where("user_id = ?", user_id)
    .order("friendships.created_at desc")
    .page(page)
    .per(limit)
  end

end
