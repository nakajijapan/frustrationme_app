# config
if ENV['RAILS_ENV'] == 'production'
  ENV['AUTH_TWITTER_KEY'] = ''
  ENV['AUTH_TWITTER_SECRET'] = ''
  ENV['API_SELF_KEY'] = ''
else
  ENV['AUTH_TWITTER_KEY'] = ''
  ENV['AUTH_TWITTER_SECRET'] = ''
  ENV['API_SELF_KEY'] = ''
end

# api_bucket                                                                                                                                                          ENV['API_BUCKET_RAKUTEN_APPLICATION_ID']      = ''
ENV['API_BUCKET_RAKUTEN_AFFILIATE_ID']        = ''
ENV['API_BUCKET_AMAZON_AWS_ACCESS_KEY_ID']    = ''
ENV['API_BUCKET_AMAZON_AWS_ACCESS_SECRET_ID'] = ''
ENV['API_BUCKET_AMAZON_ASSOCIATE_TAG']        = ''
ENV['API_BUCKET_YAHOO_AUCTION_APPID']         = ''