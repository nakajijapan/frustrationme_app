class User < ActiveRecord::Base
  attr_accessible :birthday, :crypted_password, :facebook_id, :facebook_notice, :facebook_token, :message, :pref, :sex, :twitter_id, :twitter_notice, :twitter_token, :username
end
