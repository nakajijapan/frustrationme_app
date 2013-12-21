class Item < ActiveRecord::Base
  has_one :fuman

  has_many :fumans
  accepts_nested_attributes_for :fumans

  has_many :comments
  accepts_nested_attributes_for :comments

  validates :title,   presence: true, length: { maximum: 256 }
  validates :image_s, presence: true
  validates :image_m, presence: true
  validates :image_l, presence: true

  scope :fuman_status,   lambda { |name| where("fumans.status = ?", name) if name.present? }
  scope :fuman_category, lambda { |name| where("fumans.category_id = ?", name) if name.present? }

  SERVICE_CODE_AMAZON       = 0
  SERVICE_CODE_YAHOOAUCTION = 2
  SERVICE_CODE_RAKUTEN      = 3
  SERVICE_CODE_ITUNES       = 4
  SERVICE_CODE_FRUSTRATION  = 5

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

  def self.public_timeline(params, limit=20)
    Item.order('created_at desc').page(params[:page]).per(limit)
  end

  def last_created_user
    User.joins(:fumans)
      .where('fumans.item_id = ?', self.id)
      .order('created_at desc')
      .limit(1)
      .first
  end
end
