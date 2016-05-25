# Env.
 - Ruby  2.2.0
 - Rails 4.2.3
 - SQLite3: develop & test
 - MySQL: production
 - Slim
 - Rspec
 - FactoryGirl

# SetUp

~~~
bundle install --path=vendor/bundle --jobs=4
bundle exec rake db:migrate
~~~
