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
end
