class Character < ActiveRecord::Base
  belongs_to :house
  has_many :character_events
  has_many :events, through: :character_events

  def print_messages
    puts "Title: #{self.title}"
    puts "House: #{self.house.name}"
    puts "Culture: #{self.culture}"
    puts "Id: #{self.id}"
    puts "Events attended: "
    puts self.events.collect {|event| event.name}

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

end
