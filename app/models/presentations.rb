class Presentation < Sequel::Model
  one_to_many :movie
end
