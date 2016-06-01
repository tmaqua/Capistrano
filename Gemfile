source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.3'

#-----------------------
# My Template Gem List
#-----------------------
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'unicorn'
gem 'unicorn-worker-killer'
gem 'slim-rails'
gem 'config'
gem 'dotenv-rails'
gem 'aws-sdk', '~> 2'

group :production do
  gem 'mysql2', '~> 0.3.20'
end

group :production, :staging do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
  gem 'capistrano-ami', require: false
  gem 'capistrano3-delayed-job', '~> 1.0'
end

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'json_expressions'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

#--------------------------------------
# Add 
#--------------------------------------

gem 'delayed_job', '~> 4.1.1'
gem 'delayed_job_active_record', '~> 4.1.0'
gem 'daemons', '~> 1.2.3'


#------------------
# No Use
#------------------

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
