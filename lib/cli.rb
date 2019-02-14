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
        puts "do you want to save (y/n)"
        save = gets.chomp
        system("rake db:drop") if save == "n"
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
    puts "Enter a number"
    puts "1. List all #{class_name}"
    puts "2. Get #{class_name} by name"
    gets.chomp.downcase
  end

  def list_or_find(choice, user_input)
    #puts "#{choice} and #{user_input}"
    case user_input
    when "1" #listing
      puts "1"
      case choice
      when "1"
        Character.all.each_with_index do |character, index|
          puts "#{index}. #{character.name}\n"
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
      name = gets.chomp
      case choice
      when "1" #find character
        character = Character.find_by(name:  name)
        if character
          puts "Title: #{character.title}"
          puts "House: #{character.house.name}"
          puts "Culture: #{character.culture}"
          puts "Id: #{character.id}"
          puts "Events attended: "
          puts character.events.collect {|event| event.name}
        else
          puts "That character doesn't exist!"
        end
      when "2" #find House
        house = House.find_by(name:  name)
        if house
          puts "Region: #{house.region.name}"
          puts "Coat of Arms: #{house.coat_of_arms}"
          puts "Ancestral Weapon: #{house.ancestral_weapon}"
          puts "Id: #{house.id}"
        else
          puts "That house doesn't exist!"
        end
      when "3" #find Region
        region = Region.find_by(name:  name)
        if region
          puts "Id: #{region.id}"
        else
          puts "That region doesn't exist"
        end
      when "4" #find Event
        event = Event.find_by(name:  name)
        if event
          puts "Region: #{event.region.name}"
          puts "Id: #{event.id}"
          puts "Attendees: "
          puts event.characters.collect {|char| char.name}
        else
          puts "That event doesn't exist!"
        end
      end
    else
      puts "Invalid choice! SHAME!!! *rings bell*"
    end
  end



end
