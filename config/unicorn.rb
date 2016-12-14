# vim config/unicorn.rb
def rails_root
  File.expand_path('../../', __FILE__)
end

def rails_env_
  ENV['RAILS_ENV'] || "development"
end

def shared_path
  "/home/wkojiro/message-board2/shared"
end

def path_by_rails_env
  if rails_env == "production"
    shared_path
  else
    rails_root
  end
end

worker_processes 2
working_directory rails_root
listen "#{path_by_rails_env}/tmp/#{rails_env}_unicorn.sock"
pid "#{path_by_rails_env}/tmp/#{rails_env}_unicorn.pid"
stderr_path "#{rails_root}/log/#{rails_env}_unicorn_error.log"
stdout_path "#{rails_root}/log/#{rails_env}_unicorn.log"
preload_app true