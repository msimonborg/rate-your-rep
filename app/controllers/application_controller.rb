require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "track_your_rep_secret_sessions"
    set :public_folder, 'public'
    set :views, 'app/views'
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

  post '/geo' do
    @reps = Rep.find_by_geo(params)
    erb "<%= @reps.last.url %>"
  end

  helpers do
    include Helpers
  end
end
