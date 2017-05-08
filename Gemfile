# frozen_string_literal: true

source 'http://rubygems.org'

ruby '2.4.1'

gem 'activerecord', '~> 5.1.0', require: 'active_record'
gem 'bcrypt'
gem 'httparty'
gem 'pyr', '~> 0.1.0'
gem 'rack-flash3'
gem 'rake'
gem 'require_all'
gem 'sinatra'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
gem 'tux'

group :development, :test do
  gem 'coveralls', '~> 0.8.0', require: false
  gem 'pry', '~> 0.10.4'
  gem 'rubocop', '~> 0.48.0', '>= 0.48.1'
  gem 'shotgun'
  gem 'simplecov', '~> 0.14.0', require: false
  gem 'sqlite3', platform: %i[ruby mswin mingw]
  gem 'thin'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
  gem 'rack-test'
  gem 'rspec'
end

group :production do
  gem 'pg'
  gem 'puma'
end
