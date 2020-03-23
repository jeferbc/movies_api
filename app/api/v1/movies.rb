module Theaters
  class Movies < Grape::API
    params do
      optional :name
      optional :description
      optional :url_image
      optional :presentations
    end

    get '/movies' do
      DB[:movies].join(:presentations, movie_id: :id).where(day: params[:day]).all
    end

    post '/movies' do
      movie = Movie.new.call(params) do |m|
        m.success do |movie_id|
          { movie: movie_id }
        end

        m.failure :validate do |validation|
          { error: validation }
        end
      end
    end
  end
end
