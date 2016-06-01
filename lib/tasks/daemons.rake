namespace :daemons do
    
  desc "daemons start"
  task :start => :environment do 
    ENV['RAILS_ENV'] ||= "development"
    sh "RAILS_ENV=#{ENV['RAILS_ENV']} bin/delayed_job -n 1 start"
  end

  desc "daemons stop"
  task :stop => :environment do 
    ENV['RAILS_ENV'] ||= "development"
    sh "RAILS_ENV=#{ENV['RAILS_ENV']} bin/delayed_job stop"
  end

  desc "daemons restart"
  task :restart => :environment do 
    ENV['RAILS_ENV'] ||= "development"
    sh "RAILS_ENV=#{ENV['RAILS_ENV']} bin/delayed_job -n 1 restart"
  end

end