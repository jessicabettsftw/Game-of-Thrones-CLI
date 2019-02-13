class CLI
  def initialize()
    puts "Peter Dinklage"
  end

  def main()
    puts "Game of Thrones API:"
    puts
    #loop
    loop do
      choice = prompt_user
      case choice
      when "1"
        user_input = sub_prompt("Characters")

      when "2"
        sub_prompt("Houses")
      when "3"
        sub_prompt("Regions")
      when "4"
        sub_prompt("Events")
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
    gets.chomp.downcase
  end

  def sub_prompt(class_name)
    puts "Enter a number or exit"
    puts "1. List all #{class_name}"
    puts "2. Get #{class_name} by name"
    gets.chomp.downcase
  end

  def list_or_find(choice, user_input)
    case user_input
    when "1", #listing
      case choice
      when "1"
        Character.all.each_with_index do |character, index|
          puts "#{index}. #{character.name}"
        end
      when "2"
        House.all.each_with_index do |house, index|
          puts "#{index}. #{house.name}"
        end
      when "3"
        Region.all.each_with_index do |region, index|
          puts "#{index}. #{region.name}"
        end
      when "4"
        Event.all.each_with_index do |event, index|
          puts "#{index}. #{event.name}"
        end
      end
    when "2" #finding by name
      case choice
      when "1", #find character
        Character.find_by(name: house_hash["region"])
      when "2", "1" #list of Houses

      when "2", "2" #find Houses by name

      when "3", "1" #list of Regions

      end
    end
  end



end
