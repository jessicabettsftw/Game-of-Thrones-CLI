require_relative '../config/environment'


if File.exist?("./db/game_of_thrones.db")
  puts "do you want to start a new a game (y/n)"
  start_over = gets.chomp
  if start_over == "y"
    system("rake db:drop")
    system("rake db:migrate")
    system("rake db:seed")
  end
else
  system("rake db:migrate")
  system("rake db:seed")
end
cli = CLI.new()
cli.main
