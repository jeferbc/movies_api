require 'sequel'

Sequel::Model.plugin :json_serializer

DB = Sequel.connect(adapter: :postgres, database: "theaters_#{ENV['RACK_ENV']}",
                                        host: 'localhost',
                                        username: 'postgres', password: '')
