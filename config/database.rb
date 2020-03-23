require 'sequel'

Sequel::Model.plugin :json_serializer
DB = Sequel.connect(adapter: :postgres, database: 'theaters_development', host: 'localhost',
                                        username: 'postgres', password: '')
