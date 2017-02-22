ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

if ENV['SINATRA_ENV'] == 'development' || ENV['SINATRA_ENV'] == 'test'
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
elsif ENV['SINATRA_ENV'] == 'production'
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end

require_all 'app'
