class Murder < ActiveRecord::Base
  belongs_to :murderer, :class_name => "Character"
  belongs_to :victim, :class_name => "Character"

  def self.ressurect_character
    print "Type the characters name you wish to bring back to life:"
    character_name = gets.chomp.strip
    character = Character.find_by(name: character_name)
    if character
      if character.status == "dead"
        random_num = rand(1..10)
        if random_num > 6
          death = Murder.find_by(victim_id: character.id)
          death&.destroy
          character.update(status: "alive")
          puts "The Lord of Light has granted life to #{character.name}. They have been resurrected!"
        else
          puts "The Lord of Light has turned a blind eye to your request. #{character.name} is still very much dead!"
        end
      else
        puts "#{character.name} is not dead yet!"
      end
    else
      puts "That character does not exist!"
    end
  end
end
