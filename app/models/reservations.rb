class Reservation < Sequel::Model
  include Dry::Transaction

  step :validate
  step :create_reservation
  MAX_CAPACITY = 10

  def validate(input)
    return Failure("Username can't be blank") if validate_presence(input[:username])
    return Failure("Presentation can't be blank") if validate_presence(input[:presentation_id])
    return Failure("Presentation not found") unless validate_presentation(input[:presentation_id])
    return Failure("Presentation is full") if validate_capacity

    Success(input)
  end

  def create_reservation(input)
    reservation = DB[:reservations].insert(input)
    Success(DB[:reservations].first(id: reservation))
  end

  def validate_presence(column)
    column.nil? || column == ''
  end

  def validate_capacity
    DB[:reservations].where(presentation_id: @presentation[:id]).count >= MAX_CAPACITY
  end

  def validate_presentation(presentation)
    @presentation = DB[:presentations].first(id: presentation)
  end
end
