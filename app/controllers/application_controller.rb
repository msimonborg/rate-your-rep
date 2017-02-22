require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "rate_your_rep_secret_sessions"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure :production do
    set :database, { adapter: 'postgresql',
                     encoding: 'unicode',
                     database: 'rate_your_rep',
                     pool: 2 }
  end

  use Rack::Flash

  get '/' do
    erb :index
  end

  get '/terms-of-service' do
    erb :'terms-of-service'
  end

  get '/privacy-policy' do
    erb :'privacy-policy'
  end

  helpers do
    include Helpers
  end
end
