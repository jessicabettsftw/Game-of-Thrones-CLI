#######################################
#------------STAGE3 CLI --------------#
#######################################

class CLI

  def choose_character #returns nil to redo, a character object, or exit
    input = character_prompt
    case input
    when "list"
      puts Character.all.select{|c| c.status == "alive"}.collect{|c| c.name}.sample(50) #returns nil
    when "exit"
      "exit"
    else
     character = Character.find_by(name: input) #returns nil if character doesn't exist
     # binding.pry
     # puts input
     if !character
       puts "That's not a character"
       return nil
     elsif character.status == "dead"
       puts "That character is dead. You cannot play a dead character!"
       return nil
     end
     character
    end
  end

  def main

    welcome
    player_character = nil
    keep_playing = true
    while !player_character
      # binding.pry
      player_character = choose_character
    end

    if player_character == "exit"
      keep_playing = false
    else
      puts "You are playing as #{player_character.name}! Here is your information:"
      player_character.print_messages
    end

    while keep_playing do
      choice = prompt_user
      case choice
      when "help"
        help
      when "exit"
        keep_playing = false
      when "events"
        Event.list_all
      when "attend event"
        Event.attend(player_character)
      when "about me"
        player_character.print_messages
      when "kill"
        keep_playing = Character.kill(player_character)
      when "about characters"
        Character.about_a_character
      when "resurrect"
        Murder.ressurect_character
      else
        puts "Invalid choice! SHAME!!! *rings bell*"
      end
    end

    puts "Game Over"
  end

  private #main submethods

  def help
    puts "- exit"
    puts "- events: lists all events in Westeros"
    puts "- attend event: go to an event"
    puts "- about me: tells you about yourself"
    puts "- kill: try to kill somone"
    puts "- about characters: learn about other characters"
    puts "- resurrect: attempt to resurrect a character"
  end

  def prompt_user
    puts "What would you like to do next (type 'help' for a list of commands)"
    gets.chomp.strip
  end

  def character_prompt
    puts "Type a characters name, or type 'list' to see 50 random available characters.(or exit to exit)"
    gets.chomp.strip
  end

  def welcome
    puts "Welcome to the GOT CLI"
    print "Hi User, please choose a character to play as. " #is print so that first prompt is in line
  end

end
