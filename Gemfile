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
gem 'slim-rails'
gem 'config'
gem 'dotenv-rails'

group :production do
  gem 'mysql2', '~> 0.3.20'
end

group :production, :staging do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
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

#------------------
# No Use
#------------------

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
