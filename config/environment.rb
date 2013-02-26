# Load the rails application
require File.expand_path('../application', __FILE__)

if ENV['RAILS_ENV'] == 'production'
  require File.expand_path('../../../shared/secret', __FILE__)
else
  require File.expand_path('../secret', __FILE__)
end

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
