#######################################
#------------STAGE3 CLI --------------#
#######################################

class CLI

  @player_character_id = nil

  def player
    Character.find_by(id: @player_character_id)
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
      @player_character_id = player_character&.id
      puts "You are playing as #{self.player.name}! Here is your information:"
      self.player.print_messages
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
        Event.attend(self.player)
      when "about me"
        self.player.print_messages
      when "kill"
        keep_playing = Character.kill(self.player)
      when "about characters"
        Character.about_a_character
      when "facts"
        Character.most_murders
        Character.most_powerful
        Event.most_popular
      when "resurrect"
        Murder.ressurect_character
      when "list all"
        Character.list_all
      else
        puts "Invalid choice! SHAME!!! *rings bell*"
      end
      puts "\n\n"
    end
    puts "Game Over"
  end

  private #main submethods

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

  def help
    puts "- events: lists all eventxs in Westeros"
    puts "- attend event: go to an event"
    puts "- resurrect: attempt to resurrect a character"
    puts "- kill: try to kill somone"
    puts "- about me: tells you about yourself"
    puts "- about characters: learn about other characters"
    puts "- facts: learn about the biggest and best things in this world"
    puts "- list all: lists all (1000+) characters"
    puts "- exit"
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
