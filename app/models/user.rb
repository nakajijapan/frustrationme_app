class User < ActiveRecord::Base
  attr_accessible :birthday, :facebook_id, :facebook_notice, :facebook_token, :message, :pref, :sex, :twitter_id, :twitter_notice, :twitter_token, :username, :email
  attr_accessible :password, :password_confirmation

  attr_accessor :mode, :password

  validates :username,
    presence: {unless: :profile?},
    length:   {minimum: 4, maximum: 16, if: :password},
    format:   {with: /^[0-9a-zA-Z\-_]+$/},
    uniqueness: true

  validates :password,
    presence: {:unless => :profile?},
    length: {minimum: 4, maximum: 16, if: :password},
    format: {with: /^[0-9a-zA-Z\-_]+$/},
    confirmation: {if: :password}

  validates :email,
    format: {with: /^[\.@0-9a-zA-Z\-_]+$/},
    presence: {unless: :profile?}

  validates :sex,
    :presence => {:if => :profile?},
    :inclusion =>  {:in => [1,2], :allow_nil => true, :if => :profile?}

  before_create :password_hash

  def password_hash
    self.crypted_password = Digest::MD5.hexdigest(self.password)
  end


  def profile?
    @mode == "profile"
  end


end
