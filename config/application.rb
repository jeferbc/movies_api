require File.expand_path('../boot', __FILE__)
require File.expand_path('../database', __FILE__)
Bundler.require :default, ENV['RACK_ENV']
# Load files from the models and api folders
Dir[File.expand_path('../../app/api/v1/*.rb', __FILE__)].each { |f| require f }

module Theaters
  class Application < Grape::API
    prefix 'api'
    format :json
    mount ::Theaters::Ping
  end
end

Application = Rack::Builder.new do
  map "/" do
    run Theaters::Application
  end
end
