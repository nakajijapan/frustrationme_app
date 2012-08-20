source 'https://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
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
# gem 'unicorn'

# To use debugger
# gem 'debugger'

group :deployment, :test do
  gem 'capistrano'
  gem 'capistrano_colors'
  gem 'capistrano-ext'
  gem 'capistrano_rsync_with_remote_cache'
end

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
gem 'execjs'
gem 'therubyracer'
gem 'rake'

# To use sorcery for login system
gem 'sorcery'
# gem 'refinerycms'

# To use paginator
gem 'kaminari', '~>0.13.0'

# for development
group :development, :test do
  # rspec
  gem 'guard-coffeescript'
  gem 'rspec-rails'
  gem 'rspec'
  gem 'rspec-core'
  gem 'rspec-expectations'
  gem 'rspec-mocks'

  gem "capybara"
  gem 'nyan-cat-formatter'
end