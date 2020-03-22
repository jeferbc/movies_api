module Theaters
  class Movies < Grape::API
    format :json

    params do
      requires :name
      requires :description
      requires :url_image
    end

    get '/movies' do
      Movie.all
    end

# TODO: search for a good response
    post '/movies' do
      movie = Movie.new.call(params) do |m|
        m.success do |movie_id|
          movie_id
        end

        m.failure :validate do |validation|
          validation
        end
      end
    end
  end
end
