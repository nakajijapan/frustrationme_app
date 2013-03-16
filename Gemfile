source 'https://rubygems.org'

gem 'rails', '3.2.11'

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

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# To use debugger
# gem 'debugger'

# To use debugger
gem 'execjs'
gem 'therubyracer'
gem 'rake'

# To use sorcery for login system
#gem 'sorcery'
#gem 'refinerycms'
gem 'bcrypt-ruby', '~> 3.0.0'
#gem 'omniauth-identity'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

# To use paginator
gem 'kaminari', '~>0.14.1'

#gem 'twitter-bootstrap-rails'
gem 'settingslogic'

gem 'api_bucket'

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

    gem 'nyan-cat-formatter'
    gem 'ruby_gntp', platforms: :mswin
    gem 'pry-rails'
  end

end
