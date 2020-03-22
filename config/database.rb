require 'sequel'

DB = Sequel.connect(adapter: :postgres, database: 'theaters_development', host: 'localhost',
                                        username: 'postgres', password: '')
