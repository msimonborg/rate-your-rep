class CallsController < ApplicationController
  post '/calls' do
    if logged_in?
      @call = Call.new params
      if @call.save
        redirect '/calls'
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
