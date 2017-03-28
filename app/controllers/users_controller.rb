# frozen_string_literal: true

# Routing and controller actions for User views
class UsersController < ApplicationController
  get '/login' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by email: params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if params[:path] == '/'
        redirect "/users/#{@user.slug}"
      else
        redirect params[:path]
      end
    else
      flash[:message] = ['Incorrect email/password match, please try again.']
      redirect '/'
    end
  end

  post '/signup' do
    redirect '/' if logged_in?
    binding.pry
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = @user.errors.full_messages.uniq
      redirect '/'
    end
  end

  get '/users' do
    @users = User.all
    erb :'users/index'
  end

  get '/users/leaderboard' do
    @users = User.most_calls.limit(25)
    erb :'users/leaderboard'
  end

  get '/users/:slug' do
    @user = User.where(slug: params[:slug]).includes(:calls).take
    if @user
      erb :'users/show'
    else
      not_found
    end
  end

  get '/users/:slug/edit' do
    @user = User.find_by slug: params[:slug]
    if logged_in?
      return erb :'users/settings' if @user == current_user
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
    session.clear if logged_in?
    redirect '/'
  end

  delete '/users/:slug/delete' do
    @user = User.find_by slug: params[:slug]
    redirect '/' unless logged_in?
    if @user == current_user
      if @user.authenticate params[:password]
        @user.destroy
        flash[:message] = ['Account successfully deleted.']
        redirect '/logout'
      else
        flash[:message] = ['Incorrect password.']
        redirect "/users/#{@user.slug}/edit"
      end
    else
      redirect "/users/#{current_user.slug}/edit"
    end
  end

  private

  def user_params
    {
      username: params[:user][:username],
      email: params[:user][:email],
      password: params[:user][:password]
    }
  end
end
