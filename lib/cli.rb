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

  def choose_character
    puts "Hi User, please choose a character to play as \n
    type their name to choose them, or type 'list' to see 5o random characters
    to chose from."
     input = gets.chomp.strip

     if input.downcase == "list"
       Character.all.collect{|c| c.name}.sample(50)
       return "redo"
     else
       character = Character.exists?(input)
       character || "redo"
     end
  end

  def main
    puts "Welcome to the GOT CLI"
    character = nil
    loop do
      character = choose_character
      break unless character == "redo"
     end
     puts character
  end
end
