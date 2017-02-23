source 'http://rubygems.org'

ruby '2.3.3'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'bcrypt'
gem 'rack-flash3'
gem 'httparty'

group :development, :test do
  gem 'sqlite3'
  gem 'thin'
  gem 'shotgun'
  gem 'pry'
  gem 'tux'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :production do
  gem 'pg'
  gem 'puma'
end
