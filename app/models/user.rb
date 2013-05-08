# coding: utf-8
class User < ActiveRecord::Base
  attr_accessible :birthday, :message, :sex, :username, :email
  attr_accessible :facebook_use, :twitter_use

  attr_accessible :provider, :uid
  attr_accessible :mode, :password, :password_confirmation, :icon_name, :crypted_password
  attr_accessor :mode, :password, :password_confirmation

  has_attached_file :icon_name,
    storage: :s3,
    s3_credentials: "#{Rails.root}/config/s3.yml",
    styles: {thumb: '200x200#'},
    path: "#{Rails.env}/:id/icon_names/:style.:extension"

  validate :icon_name_size_validation, :if => "icon_name?"
  def icon_name_size_validation
    errors[:icon_name] << "should be less than 1MB" if icon_name.size > 2.megabytes
  end

  has_many :categories
  has_many :fumans
  has_many :comments

  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :fumans
  accepts_nested_attributes_for :comments

  validates :username,
    presence: true,
    length:   {minimum: 4, maximum: 16},
    format:   {with: /^[0-9a-zA-Z\-_]+$/},
    uniqueness: true

  validates :password,
    presence: {unless: :social?},
    length: {minimum: 4, maximum: 16, if: :password},
    format: {with: /^[0-9a-zA-Z\-_]+$/, if: :password},
    confirmation: {if: :password}

  validates :email,
    presence: {unless: :social?},
    format: {with: /^[\.@0-9a-zA-Z\-_]+$/, if: :email}

  validates :sex,
    inclusion: {in: [1,2], if: :sex}

  before_create :password_hash, unless: :social?

  # crypt md5
  def password_hash
    self.crypted_password = Digest::MD5.hexdigest(self.password)
  end

  def social?
    @mode == :social
  end

  def get_hash
    Digest::MD5.new.update(@id.to_s + @crypted_password.to_s)
  end

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    if auth['info']['image'].nil?
      icon_name = nil
    else
      icon_name = open(auth['info']['image'].gsub(/_normal/, ''))
    end

    params = {
      mode:      :social,
      provider:  auth['provider'],
      uid:       auth['uid'],
      username:  auth['info']['nickname'],
      icon_name: icon_name
    }
    user = User.new(params)

    if User.find_by_username(auth['info']['nickname'])
      user.errors.add 'ユーザ名', 'が既に登録済みです'
      return false
    end

    #ActiveRecord::Base.transaction do
    #  user.save!
    #end
    user.save!

    user
  end

  # 指定されたIDから自分が持っているアイテムを抽出
  def checked_items(ids)
    items = Item.joins(:fuman).where('user_id = ?', self.id).where('product_id in (?)', ids)
    list = {}
    items.map{|item| list[item.id] = item.product_id}

    list
  end

  # 登録アイテム一覧
  def items_with_fuman(params, per=10)
    Item.includes(:fuman)
    .joins(:fuman)
    .where('user_id = ?', self.id)
    .fuman_status(params[:status])
    .fuman_category(params[:category_id])
    .order('fumans.created_at desc')
    .page(params[:page]).per(per)
  end

  # フォローしているユーザを取得する
  def following(following_id)
    Friendship.where('user_id = ?',      self.id)
              .where('following_id = ?', following_id)
              .first
  end

  # count
  def count_followings
    Friendship.where('user_id = ?', self.id).count
  end

  def count_followers
    Friendship.where('following_id = ?', self.id).count
  end

  # フォローされている人一覧
  def followers(page=1, limit=10)
    Friendship.select('friendships.*, users.username, users.icon_name, users.icon_name_file_name')
      .joins("inner join users on friendships.user_id = users.id")
      .where("following_id = ?", self.id)
      .order("friendships.created_at desc")
      .page(page)
      .per(limit)
  end

  # フォローしている人
  def followings(page=1, limit=10)
    Friendship.select('friendships.*, users.username, users.icon_name, users.icon_name_file_name')
    .joins("inner join users on friendships.following_id = users.id")
    .where("user_id = ?", self.id)
    .order("friendships.created_at desc")
    .page(page)
    .per(limit)
  end

  def unfollow(id)
    Friendship.delete_all(['user_id = ? and following_id = ?', self.id, id])
  end

  def following_ids(ids)
    return [] if ids.blank?
    Friendship.where('user_id = ?', self.id).where("following_id in (?)", ids).map{|f| f.following_id}
  end

  def delete_fuman(fuman_id)
    fuman = Fuman.find_by_id_and_user_id(fuman_id, self.id)
    fuman.destroy

    Comment.delete_all(['user_id = ? and item_id = ?', self.id, fuman.item_id])

    fuman
  end
end
