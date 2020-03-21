require 'sequel'

DB = Sequel.connect(adapter: :postgres, host: 'localhost', username: 'postgres', password: '')
