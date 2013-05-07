Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['AUTH_TWITTER_KEY'], ENV['AUTH_TWITTER_SECRET']
  provider :facebook, ENV['AUTH_FACEBOOK_KEY'], ENV['AUTH_FACEBOOK_SECRET']
end