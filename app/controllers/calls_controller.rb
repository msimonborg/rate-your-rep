class CallsController < ApplicationController
  post '/calls' do
    puts params
  end

  get '/calls/new' do
    erb :'calls/new'
  end
end
