# -*- coding: utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Frustration::Application.initialize!

# ログに色づけ
class Logger
  class Formatter
    def call(severity, time, progname, msg)

      msg = msg.to_s.gsub(/(SELECT.+)/, "\033\[1;32m" + '\1' + "\033\[0m")
      msg = msg.to_s.gsub(/(UPDATE.+)/, "\033\[1;34m" + '\1' + "\033\[0m")
      msg = msg.to_s.gsub(/(DELETE.+)/, "\033\[1;33m" + '\1' + "\033\[0m")
      msg = msg.to_s.gsub(/(INSERT.+)/, "\033\[1;35m" + '\1' + "\033\[0m")

      case severity
        when "FATAL"
          # \033[#{esc};#{bg};#{fg}m hogehoge \033[0m
          "#{time.to_s(:db)} \033[1;33;41m[#{severity}]\033[0m #{msg}\n"
        when "ERROR"
          "#{time.to_s(:db)} \033[1;33;45m[#{severity}]\033[0m #{msg}\n"
        when "WARN"
          "#{time.to_s(:db)} \033[1;30;43m[#{severity}]\033[0m #{msg}\n"
        when "INFO"
          "#{time.to_s(:db)} \033[1;36;40m[#{severity}]\033[0m #{msg}\n"
        else
          "#{time.to_s(:db)} \033[1;34;40m[#{severity}]\033[0m #{msg}\n"
        end
    end
  end
end

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => ENV['MAIL_USERNAME'],
  :password             => ENV['MAIL_PASSWORD'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}