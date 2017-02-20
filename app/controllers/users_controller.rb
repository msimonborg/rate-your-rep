class UsersController < ApplicationController
  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by email: params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:message] = ["Incorrect email/password match, please try again."]
      redirect '/login'
    end
  end

  post '/signup' do
    @user = User.new params
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:message] = @user.errors.full_messages.uniq
      redirect '/'
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :'users/signup'
    end
  end

  get '/users/:id' do
    erb :'users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect '/'
  end
end
