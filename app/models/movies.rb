class Movie
  include Dry::Transaction

  step :validate
  step :create_movie

  def validate(input)
    return Failure("Name can't be blank") if validate_presence(input[:name])
    return Failure("Description can't be blank") if validate_presence(input[:description])
    return Failure("Image URL can't be blank") if validate_presence(input[:url_image])

    Success(input)
  end

  def create_movie(input)
    movies = DB[:movies]
    movies.insert(input)
    Success(movies.order(:id).last)
  end

  def validate_presence(column)
    column.nil? || column == ''
  end
end
