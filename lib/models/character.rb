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


end
