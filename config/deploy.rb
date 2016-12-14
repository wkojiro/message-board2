# config valid only for current version of Capistrano
lock '3.7.0'
application = 'message-board3'
set :application, 'message-board3'
set :repo_url, 'https://github.com/wkojiro/message-board2.git'

set :linked_files, %w{ config/database.yml config/secrets.yml }
set :linked_dirs, %w{
  log tmp/pids tmp/cache tmp/sockets config/unicorn
}
set :unicorn_pid, "/tmp/unicorn_#{application}.pid"

set :rails_env, 'production'
# サーバー上に保持する過去世代数 20161213
set :keep_releases, 5
#
#
# unicornの停止がCapからできない場合は下記参照
#http://h3poteto.hatenablog.com/entry/2015/05/10/192100
#set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/sockets vendor/bundle}
#set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"
#set :unicorn_config_path, "#{release_path}/config/unicorn.rb"
#
#
#


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Upload database.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/database.yml', "#{shared_path}/config/database.yml")
    end
  end

  desc 'Create Database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
      end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app) do
      invoke 'unicorn:restart'
    end
  end

  before :starting, :upload
  after :publishing, :restart

end
