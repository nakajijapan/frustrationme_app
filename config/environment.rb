# -*- coding: utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Frustration::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => ENV['MAIL_USERNAME'],
  :password             => ENV['MAIL_PASSWORD'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
