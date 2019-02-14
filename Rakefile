require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  def access_characters
    response = RestClient.get("https://api.got.show/api/characters/")
    JSON.parse(response.body)
  end
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

desc "runs CLI through runfile"
task :run do
  require_relative 'bin/run.rb'
end
