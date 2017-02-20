require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "track_your_rep_secret_sessions"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  use Rack::Flash

  get '/' do
    'hello world'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      # User.find session[:user_id]
    end
  end
end
