require 'grape_helper'

RSpec.describe "Movie" do
  describe "GET /api/movies?day" do
    before do
      create_movies
      get "/api/movies?day=#{Time.now.strftime("%Y-%m-%d")}"
    end

    it "returns movies with presentations in a day" do
      expect(last_response.ok?).to be true
      expect(json.count).to eq 1
    end
  end

  describe "POST /api/movies" do
    context 'valid params' do
      before do
        presentations = { day: (Time.now + 1.day).strftime("%Y-%m-%d") }, { day: (Time.now + 2.day).strftime("%Y-%m-%d") }
        valid_data = { name: Faker::Movie.quote, description: Faker::Lorem.paragraph,
                       url_image: 'https://fakeimg.pl/300/',
                       presentations: [presentations] }
        post '/api/movies', valid_data
      end

      it "create movie and presentations" do
        expect(last_response.status).to be 201
        expect(json.count).to eq 1
        expect(DB[:presentations].count).to eq 2
        expect(json['movie']).to_not be nil
      end
    end

    context 'invalid params' do
      before do
        post '/api/movies'
      end

      it "return validation error" do
        expect(last_response.status).to be 201
        expect(json.count).to eq 1
        expect(json['error']).to_not be nil
      end
    end
  end
  
  def create_movies
    5.times.with_index do |index|
      data = { name: Faker::Movie.quote, description: Faker::Lorem.paragraph,
               url_image: 'https://fakeimg.pl/300/' }
      movie = DB[:movies].insert(data)
      day = (Time.now + index.day).strftime("%Y-%m-%d")
      presentation = DB[:presentations].insert({ day: day, movie_id: movie })
    end
  end
end
