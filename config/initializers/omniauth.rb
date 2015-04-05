Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['AUTH_TWITTER_KEY'], ENV['AUTH_TWITTER_SECRET']
end
