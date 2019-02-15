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
    puts "Status: #{self.status}"
    puts "Id: #{self.id}"
    puts "Events attended: "
    puts self.events.collect {|event| event.name}
    # binding.pry
  end

  #######Class Methods#######

  def self.most_murders
    killer = self.all.max_by{|character| character.kills.count}
    victim_names = killer.victims.collect {|v| v.name}
    puts "The character with the most kills is #{killer.name}. They've killed these people: #{victim_names}"
  end

  def self.most_powerful
    m_p = self.all.max_by{|character| character.title&.length || 0}#in case title is nil
    puts "The most powerful character is #{m_p.name}. They cannot be killed!"
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
      if victim.id == character.id
        puts "You can't kill yourself"
        return true #keep playing
      end
      if victim.status  == "dead"
        puts "#{victim.name} is already dead! The dead are already dead."
        return true #keep playing
      end
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
      return true #keep playing
    end
  end

  def self.about_a_character
    puts "Who would you like to find out about?"
    input = gets.chomp.strip
    Character.exists?(input)
  end

  def self.lose(character, victim)
    Murder.create(victim_id: character.id, murderer_id: victim.id)
    Character.find_by(id: character.id).update(status: "dead")
    puts "FOOL! YOU HAVE BEEN KILLED BY #{victim.name}!!! Their strength was too much, and you were too weak..."
    return false #keep playing is false
  end

  def self.win(character, victim)
    Murder.create(victim_id: victim.id, murderer_id: character.id)
    Character.find_by(id: victim.id).update(status: "dead")
    puts "You killed #{victim.name}. I hope you're happy :("
    return true #keep playing
  end

end
