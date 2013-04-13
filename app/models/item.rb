class Item < ActiveRecord::Base
  attr_accessible :product_id, :release_date, :description, :url, :preview_url
  attr_accessible :image_l, :image_m, :image_s, :is_adult, :service_code, :price, :title

  has_one :fuman

  has_many :fumans
  accepts_nested_attributes_for :fumans

  has_many :comments
  accepts_nested_attributes_for :comments

  def users_with_status(status, count=50)
    User.joins(:fumans)
      .where('item_id = ?', self.id)
      .where('status = ?', status)
      .order('fumans.created_at desc')
      .limit(count)
  end

  def comment_list
    Comment.select('comments.*, users.icon_name, users.username')
      .joins(:user)
      .where('item_id = ?', self.id)
      .order('comments.created_at')
  end
end
