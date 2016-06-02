require 'dotenv'
Dotenv.load

namespace :push do
    
  desc "rpush certificate file install"
  task :install => :environment do 
    app_name = ENV['APN_NAME']
    apns_env = ENV['APN_ENV'] ? ENV['APN_ENV'] : (Rails.env.production? ? 'production' : 'sandbox')

    if Rpush::Apns::App.where(name: app_name, environment: apns_env).exists?
      puts "Already exists!, Name:#{app_name}, Env:#{apns_env}"
      next # end the task
    end

    certificate_path = Rails.root.join('certificate', 'apn', "#{apns_env}.pem")
    Rpush::Apns::App.create!(
      name: app_name,
      certificate: File.read(certificate_path),
      environment: apns_env,
      password: ENV['APN_PASSWORD'],
      connections: 1
    )
    puts "Saved!, Name:#{app_name}, Env:#{apns_env}"
  end

  desc "rpush certificate file uninstall"
  task :uninstall => :environment do 
    app_name = ENV['APN_NAME']
    apns_env = ENV['APN_ENV'] ? ENV['APN_ENV'] : (Rails.env.production? ? 'production' : 'sandbox')

    if Rpush::Apns::App.where(name: app_name, environment: apns_env).exists?
      puts "Exists!, Name:#{app_name}, Env:#{apns_env}"
      Rpush::Apns::App.where(name: app_name, environment: apns_env).each do |apns|
        apns.destroy
      end
    else
      puts "Not found!, Name:#{app_name}, Env:#{apns_env}"
    end
  end

end