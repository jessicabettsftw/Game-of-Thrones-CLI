require_relative '../config/environment'


unless File.exist?("./db/game_of_thrones.db")
  system("rake db:migrate")
  system("rake db:seed")
end
cli = CLI.new()
cli.main
