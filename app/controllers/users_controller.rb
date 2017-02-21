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

  get '/users/:slug/edit' do
    @user = User.find_by slug: params[:slug]
    if logged_in?
      return erb :'users/edit' if @user == current_user
      @user = current_user
      redirect "/users/#{@user.slug}/edit"
    else
      redirect '/'
    end
  end

  patch '/users/:slug' do
    @user = User.find_by slug: params[:slug]
    if @user.authenticate params[:password]
      if params[:new_password]
        @user.password = params[:new_password]
      else
        @user.username = params[:username]
        @user.email    = params[:email]
        @user.password = params[:password]
        @user.add_slug
      end
      flash[:message] = @user.errors.full_messages unless @user.save
    else
      flash[:message] = ['Password does not match']
    end
    redirect "/users/#{@user.slug}/edit"
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect '/'
  end
end
