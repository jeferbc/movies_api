module Theaters
  class Reservations < Grape::API
    params do
      optional :username
      optional :presentation_id
      optional :start_day
      optional :end_day
    end

    get '/reservations' do
      range = Time.parse(params[:start_day]) .. Time.parse(params[:end_day])
      DB[:presentations].join(:reservations, presentation_id: :id).where(day: range).all
    end

    post '/reservations' do
      Reservation.new.call(params) do |m|
        m.success do |reservation_id|
          { reservation: reservation_id }
        end

        m.failure :validate do |validation|
          { error: validation }
        end
      end
    end
  end
end
