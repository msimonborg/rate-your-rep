class UsersController < ApplicationController
  post '/login' do
    @user = User.find_by email: params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = ["Incorrect email/password match, please try again."]
      redirect '/'
    end
  end

  post '/signup' do
    @user = User.new params
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = @user.errors.full_messages.uniq
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.where(slug: params[:slug]).includes(:calls).take
    erb :'users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect '/'
  end
end
