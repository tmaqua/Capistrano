namespace :rpush do
  task :environment do
    set :rpush_pid, "#{shared_path}/tmp/pids/rpush.pid"
  end

  def start_rpush
    within current_path do
      with rails_env: fetch(:rails_env) do
        execute :bundle, :exec, :rpush, :start, "-e #{fetch(:rails_env)}"
      end
    end
  end

  def stop_rpush
    execute :kill, "-s QUIT $(< #{fetch(:rpush_pid)})"
    execute "rm #{fetch(:rpush_pid)}"
  end

  def reload_rpush
    execute :kill, "-s HUP $(< #{fetch(:rpush_pid)})"
  end

  def rpush_process_exists?
    test("[ -e #{fetch(:rpush_pid)} ]")
  end


  desc 'Install rpush settings to DB'
  task :install => :environment do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'push:install'
        end
      end
    end
  end

  desc 'Start rpush server'
  task :start => :environment do
    on roles(:app) do
      start_rpush
    end
  end

  desc 'Stop rpush server'
  task :stop => :environment do
    on roles(:app) do
      stop_rpush
    end
  end

  desc 'Restart rpush server'
  task :restart => :environment do
    on roles(:app) do
      if rpush_process_exists?
        execute "rm #{fetch(:rpush_pid)}"
        reload_rpush
      else
        start_rpush
      end
    end
  end
end