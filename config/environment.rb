# -*- coding: utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)

if ENV['RAILS_ENV'] == 'production'
  require File.expand_path('../../../shared/secret', __FILE__)
elsif ENV['RAILS_ENV'] == 'test'
  require File.expand_path('../secret_skel.rb', __FILE__)
else
  require File.expand_path('../secret', __FILE__)
end

# Initialize the rails application
Frustration::Application.initialize!
