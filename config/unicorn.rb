# vim config/unicorn.rb
def rails_root
  File.expand_path('../../', __FILE__)
  # "/home/wkojiro/message-board2/current"
end

# def rails_env_
#   ENV['RAILS_ENV'] || "development"
# end

def shared_path
  "/home/wkojiro/message-board2/shared"
end

# def path_by_rails_env
#   if rails_env == "production"
#     shared_path
#   else
#     rails_root
#   end
# end

worker_processes 2
working_directory "/home/wkojiro/message-board2/current"
listen "/home/wkojiro/message-board2/shared/tmp/production_unicorn.sock"
pid "/home/wkojiro/message-board2/shared/tmp/production_unicorn.pid"
stderr_path "#{rails_root}/log/production_unicorn_error.log"
stdout_path "#{rails_root}/log/production_unicorn.log"
preload_app true



