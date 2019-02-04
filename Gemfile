# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.4.1'

gem 'activerecord', '~> 5.1.0', require: 'active_record'
gem 'bcrypt', '~> 3.1.0', '>= 3.1.11'
gem 'pyr', '~> 0.4.0'
gem 'rack-flash3', '~> 1.0.0', '>= 1.0.5'
gem 'rake', '~> 12.0.0'
gem 'require_all', '~> 1.4.0'
gem 'safe_yaml'
gem 'sinatra', '~> 2.0.2'
gem 'sinatra-activerecord',
    '~> 2.0.0',
    '>= 2.0.13',
    require: 'sinatra/activerecord'
gem 'tux', '~> 0.3.0'

group :development, :test do
  gem 'coveralls', '~> 0.8.0', require: false
  gem 'pry', '~> 0.10.4'
  gem 'rubocop', '~> 0.48.0', '>= 0.48.1'
  gem 'shotgun', '~> 0.9.0', '>= 0.9.2'
  gem 'simplecov', '~> 0.14.0', require: false
  gem 'sqlite3', '~> 1.3.0', '>= 1.3.13', platform: %i[ruby mswin mingw]
  gem 'thin', '~> 1.7.0'
end

group :test do
  gem 'capybara', '~> 2.14.0'
  gem 'database_cleaner', '~> 1.6.0', git: 'https://github.com/bmabey/database_cleaner.git'
  gem 'rack-test', '~> 0.6.0', '>= 0.6.3'
  gem 'rspec', '~> 3.6.0'
end

group :production do
  gem 'pg', '~> 0.20.0'
  gem 'puma', '~> 3.0'
end
