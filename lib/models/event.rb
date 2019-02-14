class Event < ActiveRecord::Base
  has_many :character_events
  has_many :characters, through: :character_events
  belongs_to :region

  def print_messages
    puts "Region: #{self.region.name}"
    puts "Id: #{self.id}"
    puts "Attendees: "
    puts self.characters.collect {|char| char.name}
  end
end
