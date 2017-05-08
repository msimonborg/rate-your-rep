# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

if production?
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
elsif test?
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: ':memory:',
    timeout: 500
  )
else
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
end

require_all 'app'
