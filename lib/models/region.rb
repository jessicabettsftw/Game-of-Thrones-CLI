class Region < ActiveRecord::Base
  has_many :houses
  has_many :events

  def print_messages
    puts "Id: #{self.id}"
  end
end
