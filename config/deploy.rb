require 'dotenv'
require 'aws-sdk'
Dotenv.load

lock '3.4.0'

set :application, "Capistrano"
set :repo_url, "git@github.com:tmaqua/Capistrano.git"
# set :repo_url, "https://gitlab.planningdev.com/murakami/Capistrano.git"
set :branch, "master"
set :deploy_to, "/var/www/rails/Capistrano"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
# set :linked_files, fetch(:linked_files, []).push('config/settings/production.yml')
set :linked_files, fetch(:linked_files, []).push('.env')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :rbenv_ruby, '2.2.0'
# set :rbenv_path, '/home/fankami/.rbenv'
set :rbenv_type, :user
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_prefix, "#{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, "config/unicorn.conf.rb"

set :aws_region, 'ap-northeast-1'
set :base_ami_name, 'Template'
set :keep_amis, 3 
set :aws_access_key_id, ENV['AWS_ACCESS_KEY_ID']
set :aws_secret_access_key, ENV['AWS_SECRET_ACCESS_KEY']  

namespace :deploy do

  desc 'Upload env'
  task :upload do
    on roles(:app) do |host|
      upload!('.env', "#{shared_path}/.env")
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  desc 'db_seed must be run only one time right after the first deploy'
  task :db_seed do
    on roles(:db) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart
  # after "deploy:check:linked_dirs", :upload

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
