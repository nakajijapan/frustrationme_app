source 'https://rubygems.org'

gem 'rails', '4.0.3'
gem 'mysql2'

group :assets do
  gem 'sass-rails',   '~> 4.0.0'
  gem 'less-rails'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'execjs'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

gem 'unicorn'
gem 'rake'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

gem 'kaminari', '~>0.14.1'
gem 'settingslogic'
gem 'api_bucket'
gem 'paperclip'
gem 'aws-sdk'
gem 'mail-iso-2022-jp'
gem 'rabl'
gem 'yajl-ruby'
gem 'newrelic_rpm'
gem 'google_drive'
gem 'non-stupid-digest-assets'

# for development
group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler', :require => false
  gem 'guard-coffeescript'

  group :test do
    gem 'guard-rspec'
    gem 'guard-spork'

    gem 'launchy'
    gem 'database_cleaner'
    gem "factory_girl_rails"
    gem "capybara"

    # rspec
    gem 'rspec-rails'

    gem 'ruby_gntp', platforms: :mswin
    gem 'pry-rails'

    gem 'simplecov', require: false
    gem 'coveralls', require: false
  end
end
