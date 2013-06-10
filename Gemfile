source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'less-rails'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'unicorn'
gem 'execjs'
gem 'therubyracer'
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

# for development
group :development do
  gem 'capistrano'
  gem 'capistrano_colors'
  gem 'capistrano-ext'
  gem 'capistrano_rsync_with_remote_cache'
  gem 'guard-coffeescript'

  group :test do
    gem 'guard-rspec'
    gem 'guard-spork'
    #gem 'guard-jasmine'

    # js
    #gem 'jasminerice'
    #gem 'headless'

    gem 'launchy'
    gem 'database_cleaner'
    gem "factory_girl_rails"
    gem "capybara"

    # rspec
    gem 'guard-coffeescript'
    gem 'rspec-rails'

    gem 'ruby_gntp', platforms: :mswin
    gem 'pry-rails'

    gem 'simplecov', require: false
    gem 'coveralls', require: false
  end

end
