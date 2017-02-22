class CallsController < ApplicationController
  get '/calls' do
    @calls = Call.order('created_at DESC')
    erb :'calls/index'
  end

  get '/calls/recent' do
    @calls = Call.this_week.order('created_at DESC')
    erb :'calls/recent'
  end

  post '/calls' do
    if logged_in?
      @call = Call.new params
      if @call.save
        flash[:message] = ["Your call to #{@call.rep.official_full} was saved successfully!"]
        redirect '/calls/recent'
      else
        flash[:message] = @call.errors.full_messages
        redirect "/calls/new/#{params[:office_id]}"
      end
    else
      redirect '/login'
    end
  end

  get '/calls/new/:office_id' do
    @office = OfficeLocation.find params[:office_id]
    erb :'calls/new'
  end
end
