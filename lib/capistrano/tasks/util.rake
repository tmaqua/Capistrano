namespace :util do
  desc 'Upload env/pem'
  task :upload do
    on roles(:app) do |host|
      upload!('.env', "#{shared_path}/.env")
      upload!('certificate/apn/sandbox.pem', "#{shared_path}/certificate/apn/sandbox.pem")
    end
  end
end