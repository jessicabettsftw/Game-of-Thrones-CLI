class Character < ActiveRecord::Base
  belongs_to :house
  has_many :character_events
  has_many :events, through: :character_events

  has_one :death, :class_name => "Murder", :foreign_key => "victim_id"
  has_one :murderer, through: :death, source: :murderer

  has_many :kills, :class_name => "Murder", :foreign_key => "murderer_id"
  has_many :victims, through: :kills, source: :victim

  def print_messages
    puts "Title: #{self.title}"
    puts "House: #{self.house.name}"
    puts "Culture: #{self.culture}"
    puts "Id: #{self.id}"
    # puts "Events attended: "
    # puts self.events.collect {|event| event.name}
    # binding.pry
  end

  def self.list_all
    puts
    self.all.each_with_index do |character, index|
      puts "#{index + 1}. #{character.name}\n"
    end
  end

  def self.exists?(name)
    character = self.find_by(name:  name)
    if character
      character.print_messages
      return character
    else
      puts "That character doesn't exist!"
    end
  end

  def self.kill(character)
    puts "Type a characters name to engage them in a battle to the death!"
    victim_name = gets.chomp.strip
    victim = Character.find_by(name: victim_name)
    if victim
      if !victim.title
        self.win(character,victim)
      else
        if !character.title
          self.lose(character,victim)
        else
          if character.title.length > victim.title.length
            self.win(character,victim)
          else
            self.lose(character,victim)
          end
        end
      end
    else
      puts "That character doesn't exist!"
      return false #keep playing
    end
  end

  def self.lose(character, victim)
    Murder.create(victim_id: character.id, murderer_id: victim.id)
    puts "FOOL! YOU HAVE BEEN KILLED BY #{victim.name}!!! Their strength was too much, and you were too weak..."
    return false #keep playing is false
  end

  def self.win(character, victim)
    Murder.create(victim_id: victim.id, murderer_id: character.id)
    puts "You killed #{victim.name}. I hope you're happy :("
    return true #keep playing
  end

end
