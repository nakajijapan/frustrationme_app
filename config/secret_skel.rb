# config
if ENV['RAILS_ENV'] == 'production'
  ENV['AUTH_TWITTER_KEY']     = ''
  ENV['AUTH_TWITTER_SECRET']  = ''
  ENV['API_SELF_KEY']         = ''
  ENV['AUTH_FACEBOOK_KEY']    = ''
  ENV['AUTH_FACEBOOK_SECRET'] = ''
else
  ENV['AUTH_TWITTER_KEY']     = ''
  ENV['AUTH_TWITTER_SECRET']  = ''
  ENV['API_SELF_KEY']         = ''
  ENV['AUTH_FACEBOOK_KEY']    = ''
  ENV['AUTH_FACEBOOK_SECRET'] = ''
end

# api_bucket                                                                                                                                                          ENV['API_BUCKET_RAKUTEN_APPLICATION_ID']      = ''
ENV['API_BUCKET_RAKUTEN_AFFILIATE_ID']        = ''
ENV['API_BUCKET_AMAZON_AWS_ACCESS_KEY_ID']    = ''
ENV['API_BUCKET_AMAZON_AWS_ACCESS_SECRET_ID'] = ''
ENV['API_BUCKET_AMAZON_ASSOCIATE_TAG']        = ''
ENV['API_BUCKET_YAHOO_AUCTION_APPID']         = ''

# s3
ENV['S3_ACCESS_KEY_ID']     = ''
ENV['S3_SECRET_ACCESS_KEY'] = ''
ENV['S3_HOST_NAME']         = ''

# db
ENV['DB_ADAPTER']  = ''
ENV['DB_USERNAME'] = ''
ENV['DB_PASSWORD'] = ''
ENV['DB_DATABASE'] = ''
ENV['DB_HOST']     = ''

# mail
ENV['MAIL_USERNAME'] = ''
ENV['MAIL_PASSWORD'] = ''