# coding: utf-8
class User < ActiveRecord::Base
  attr_accessible :birthday, :message, :sex, :username, :email
  attr_accessible :facebook_use, :twitter_use

  attr_accessible :provider, :uid
  attr_accessible :mode, :password, :password_confirmation, :icon_name
  attr_accessor :mode, :password, :password_confirmation

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
end
