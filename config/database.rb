require 'sequel'

Sequel::Model.plugin :json_serializer


if ENV['RACK_ENV'] == 'production'
  DB = Sequel.connect(adapter: :postgres, url: ENV['DATABASE_URL'])
else
  DB = Sequel.connect(adapter: :postgres, database: "theaters_#{ENV['RACK_ENV']}",
                                          host: 'localhost',
                                          username: 'postgres', password: '')
end
