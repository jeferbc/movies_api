require 'grape_helper'

RSpec.describe "Reservations" do
  describe "GET /api/reservations?start_day&end_day" do
    before do
      create_resources
      start_day = Time.now.strftime("%Y-%m-%d")
      end_day = (Time.now + 2.day).strftime("%Y-%m-%d")
      get "/api/reservations?start_day=#{start_day}&end_day=#{end_day}"
    end

    it "returns movies with presentations in a day" do
      expect(last_response.ok?).to be true
      expect(json.count).to eq 3
    end
  end

  describe "POST /api/movies" do
    context 'valid params' do
      before do
        create_resources
        data = { username: Faker::Lorem.word, presentation_id: DB[:presentations].order(:id).last[:id] }
        post '/api/reservations', data
      end

      it "create the reservation" do
        expect(last_response.status).to be 201
        expect(json.count).to eq 1
        expect(DB[:reservations].count).to eq 6
        expect(json['reservation']).to_not be nil
      end
    end

    context 'invalid params' do
      before do
        post '/api/reservations'
      end

      it "return validation error" do
        expect(last_response.status).to be 201
        expect(json.count).to eq 1
        expect(json['error']).to_not be nil
      end
    end

    context 'presentation full' do
      before do
        create_resources
        create_reservations
        data = { username: Faker::Lorem.word, presentation_id: DB[:presentations].order(:id).last[:id] }
        post '/api/reservations', data
      end

      it "return validation error" do
        expect(last_response.status).to be 201
        expect(json.count).to eq 1
        expect(json['error']).to_not be nil
      end
    end
  end

  def create_resources
    5.times.with_index do |index|
      data = { name: Faker::Movie.quote, description: Faker::Lorem.paragraph,
               url_image: 'https://fakeimg.pl/300/' }
      movie = DB[:movies].insert(data)
      day = (Time.now + index.day).strftime("%Y-%m-%d")
      presentation = DB[:presentations].insert({ day: day, movie_id: movie })
      reservation = DB[:reservations].insert({ username: Faker::Lorem.word, presentation_id: presentation })
    end
  end

  def create_reservations
    presentation = DB[:presentations].order(:id).last[:id]
    data = { username: Faker::Lorem.word, presentation_id: presentation }
    10.times do
      DB[:reservations].insert(data)
    end
  end
end
