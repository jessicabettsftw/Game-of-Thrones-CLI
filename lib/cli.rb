class XCLI
  def initialize()

  end

  def main()
    puts
    puts "Game of Thrones API:"
    puts
    #loop
    loop do
      choice = prompt_user
      case choice
      when "1"
        user_input = sub_prompt("Characters")
        list_or_find(choice, user_input)
      when "2"
        user_input = sub_prompt("Houses")
        list_or_find(choice, user_input)
      when "3"
        user_input = sub_prompt("Regions")
        list_or_find(choice, user_input)
      when "4"
        user_input = sub_prompt("Events")
        list_or_find(choice, user_input)
      when "exit"
        break
      else
        puts "Invalid choice! SHAME!!! *rings bell*"
      end
    end

  end

  def prompt_user
    puts "Enter a number or exit"
    puts "1. Characters"
    puts "2. Houses"
    puts "3. Regions"
    puts "4. Events"
    gets.chomp.downcase.strip
  end

  def sub_prompt(class_name)
    puts "Enter a number"
    puts "1. List all #{class_name}"
    puts "2. Get #{class_name} by name"
    gets.chomp.downcase.strip
  end

  def list_or_find(choice, user_input)
    #puts "#{choice} and #{user_input}"
    case user_input
    when "1" #listing
      puts "1"
      case choice
      when "1"
        Character.list_all
      when "2"
        House.list_all
      when "3"
        Region.list_all
      when "4"
        Event.list_all
      end
    when "2" #finding by name
      name = gets.chomp
      case choice
      when "1" #find character
        Character.exists?(name)
      when "2" #find House
        House.exists?(name)
      when "3" #find Region
        Region.exists?(name)
      when "4" #find Event
        Event.exists?(name)
      end
    else
      puts "Invalid choice! SHAME!!! *rings bell*"
    end
  end



end

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
