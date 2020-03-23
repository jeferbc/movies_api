ENV['RACK_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
Dir[File.expand_path('../../spec/support/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Helpers
end

def app
  app = Rack::Builder.parse_file("config.ru").first
  builder = Rack::Builder.new
  builder.run app
end
