# -*- coding: utf-8 -*-

# application name
application = 'app'

# ワーカーの数
worker_processes 3

# ログ
rails_env = ENV['RAILS_ENV'] || 'production'
case rails_env
  when 'production'
    app_path = "/var/www/#{application}/current/"
    stderr_path 'log/unicorn.log'
    stdout_path 'log/unicorn.log'
  when 'test'
    app_path = "/var/www/#{application}/current/"
  when 'development'
    app_path = "/var/www/frustration/"
end

# precess id
pid "#{app_path}tmp/pids/unicorn.pid"

# capistrano 用に RAILS_ROOT を指定
working_directory app_path

# ソケット
listen "#{app_path}tmp/sockets/unicorn.sock"

preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      # SIGTTOU だと worker_processes が多いときおかしい気がする
      Process.kill :QUIT, File.read(old_pid).to_i
      rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
