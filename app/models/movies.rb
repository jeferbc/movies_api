class Movie < Sequel::Model
  include Dry::Transaction

  many_to_one :presentations

  step :validate
  step :create_movie
  step :create_presentations

  def validate(input)
    return Failure("Name can't be blank") if validate_presence(input[:name])
    return Failure("Description can't be blank") if validate_presence(input[:description])
    return Failure("Image URL can't be blank") if validate_presence(input[:url_image])
    return Failure("Presentation date is invalid") if validate_presentations(input[:presentations])

    Success(input)
  end

  def create_movie(input)
    movies = DB[:movies]
    presentations = input.extract!(:presentations)
    movies.insert(input)
    Success(presentations)
  end

  def create_presentations(input)
    movie =  DB[:movies].order(:id).last
    return Success(movie) if input.nil? || input.empty?
    presentations = input[:presentations].map do |presentation|
      DB[:presentations].insert(presentation.merge(movie_id: movie[:id]))
    end
    Success(movie.merge(presentations: DB[:presentations].where(id: presentations).all))
  end

  def validate_presentations(column)
    return if column.nil? || column.empty?

    column.each do |p|
      return true if validate_presence(p[:day]) || Time.parse(p[:day]) < Time.now
    end
    false
  end

  def validate_presence(column)
    column.nil? || column == ''
  end
end
