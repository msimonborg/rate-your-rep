# frozen_string_literal: true

# Routing and controller actions for Rep views
class RepsController < ApplicationController
  get '/reps' do
    @reps = Rep.active.order('family_name ASC')
    erb :'reps/index'
  end

  post '/reps' do
    if params[:bioguide_id]
      redirect "/reps/#{params[:bioguide_id]}"
    else
      redirect '/reps'
    end
  end

  get '/reps/select' do
    @reps = Rep.active.order('family_name ASC')
    erb :'reps/select'
  end

  get '/reps/most-called' do
    @reps = Rep.active.most_called
    erb :'reps/most_called'
  end

  get '/reps/best-rated' do
    @reps = Rep.active.best_rated
    erb :'reps/best_rated'
  end

  get '/reps/geo' do
    @reps = []
    erb :'reps/geo'
  end

  post '/reps/geo' do
    @reps    = Rep.search_by_geo(params)
    @address = params[:address]
    erb :'reps/geo'
  end

  get '/reps/:bioguide_id' do
    @rep = Rep.search_by_bioguide_id(params[:bioguide_id]).first
    if @rep
      erb :'reps/show'
    else
      not_found
    end
  end
end
