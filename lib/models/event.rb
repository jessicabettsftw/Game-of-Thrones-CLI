class Event < ActiveRecord::Base
  has_many :character_events
  has_many :characters, through: :character_events
  belongs_to :region

  def self.attend(character)
    print "Name an event to go to: "
    input = gets.chomp.strip
    event = self.find_by(name: input)
    event&.print_messages || "That event does not exist!"
  end

  def print_messages
    puts "Region: #{self.region.name}"
    puts "Id: #{self.id}"
    puts "Attendees: "
    puts self.characters.collect {|char| char.name}
  end

  def self.list_all
    puts
    self.all.each_with_index do |event, index|
      puts "#{index + 1}. #{event.name}\n"
    end
  end

  def self.exists?(name)
    event = self.find_by(name:  name)
    if event
      event.print_messages
    else
      puts "That event doesn't exist!"
    end
  end
end
