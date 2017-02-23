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

  patch '/calls' do
    call = Call.find params[:id]
    if current_user == call.user
      call.rating       = params[:rating]
      call.got_through  = params[:got_through]
      call.busy         = params[:busy]
      call.voice_mail   = params[:voice_mail]
      call.mailbox_full = params[:mailbox_full]
      call.comments     = params[:comments]

      if call.save
        call_path = "#{params[:path]}#call#{call.id}-card"
        call_link = "<a href='#{call_path}'>here</a>"
        flash[:message] = ["Your review was successfully updated. View it #{call_link}."]
      else
        flash[:message] = call.errors.full_messages
      end
      redirect params[:path] || "/users/#{current_user.slug}"

    else
      redirect '/login'
    end
  end

  get '/calls/new/:office_id' do
    @office = OfficeLocation.find params[:office_id]
    erb :'calls/new'
  end
end
