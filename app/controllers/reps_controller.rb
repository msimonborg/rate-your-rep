class RepsController < ApplicationController
  get '/reps' do
    @reps = Rep.order('family_name ASC')
    erb :'reps/index'
  end

  get '/reps/most-called' do
    @reps = Rep.most_called
    erb :'reps/most_called'
  end

  get '/reps/best-rated' do
    @reps = Rep.best_rated
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
    erb :'reps/show'
  end
end
