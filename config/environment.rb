require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/game_of_thrones.db')
require_all 'lib'
# require_all 'app'
