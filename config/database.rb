require 'sequel'

Sequel::Model.plugin :json_serializer

DB = Sequel.connect(ENV['DATABASE_URL'] || "postgres://localhost/theaters_#{ENV['RACK_ENV']}")
