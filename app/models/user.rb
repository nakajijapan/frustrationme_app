# coding: utf-8
class User < ActiveRecord::Base
  attr_accessible :birthday, :message, :sex, :username, :email
  attr_accessible :facebook_use, :twitter_use

  attr_accessible :provider, :uid
  attr_accessible :mode, :password, :password_confirmation, :icon_name, :crypted_password
  attr_accessor :mode, :password, :password_confirmation

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

  def password_hash
    self.crypted_password = Digest::MD5.hexdigest(self.password)
  end

  def social?
    @mode == :social
  end

  def get_hash
    Digest::MD5.new.update(@id.to_s + @crypted_password.to_s)
  end

  # for omniauth
  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    params = {
      mode:      :social,
      provider:  auth['provider'],
      uid:       auth['uid'],
      username:  auth['info']['nickname'],
      icon_name: auth['info']['image']
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
    Item.includes(:fuman).joins(:fuman).where('user_id = ?', self.id).page(params[:page]).per(per)
  end
end
