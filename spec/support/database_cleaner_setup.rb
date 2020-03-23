require 'database_cleaner'

RSpec.configure do |config|
  databaseCleaner = DatabaseCleaner[:sequel]
  config.before(:suite) do
    databaseCleaner.strategy = :transaction
    databaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    databaseCleaner.cleaning do
      example.run
    end
  end
end
