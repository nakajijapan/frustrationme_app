require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

if ENV['RAILS_ENV'] == 'production'
  require File.expand_path('../env.rb', __FILE__)
elsif ENV['RAILS_ENV'] == 'test'
  require File.expand_path('../secret_skel.rb', __FILE__)
else
  require File.expand_path('../secret', __FILE__)
end
