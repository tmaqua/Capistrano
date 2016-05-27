# set lets
$worker  = 2
$timeout = 30

# $shared_path = "/var/www/rails/Capistrano/shared/"
# $current_path = "/var/www/rails/Capistrano/current"

# $listen = File.expand_path('tmp/sockets/unicorn.sock', $shared_path)
# $pid = File.expand_path('tmp/pids/unicorn.pid', $shared_path)
# $std_log = File.expand_path('log/unicorn.log', $shared_path)

$app_path = "/var/www/rails/Capistrano/current"
$app_dir = "/var/www/rails/Capistrano"
$listen  = File.expand_path 'shared/tmp/sockets/.unicorn.sock', $app_dir
$pid     = File.expand_path 'shared/tmp/pids/unicorn.pid', $app_dir
$std_log = File.expand_path 'shared/log/unicorn.log', $app_dir

# set config
worker_processes  $worker
# working_directory $current_path
working_directory $app_path
stderr_path $std_log
stdout_path $std_log
timeout $timeout
listen  $listen
pid $pid

# loading booster
preload_app true

# before starting processes
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

# after finishing processes
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end