ApiBucket::Rakuten.configure do |o|
  o.application_id  = ENV['API_BUCKET_RAKUTEN_APPLICATION_ID']
  o.affiliate_id    = ENV['API_BUCKET_RAKUTEN_AFFILIATE_ID']
end

ApiBucket::Amazon.configure do |o|
    o.a_w_s_access_key_id = ENV['API_BUCKET_AMAZON_AWS_ACCESS_KEY_ID']
    o.a_w_s_secret_key    = ENV['API_BUCKET_AMAZON_AWS_ACCESS_SECRET_ID']
    o.associate_tag       = ENV['API_BUCKET_AMAZON_ASSOCIATE_TAG']
end

ApiBucket::Yahooauction.configure do |o|
    o.appid = ENV['API_BUCKET_YAHOO_AUCTION_APPID']
end
