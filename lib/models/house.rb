class House < ActiveRecord::Base
  has_many :characters
  belongs_to :region

  def print_messages
    puts "Region: #{self.region.name}"
    puts "Coat of Arms: #{self.coat_of_arms}"
    puts "Ancestral Weapon: #{self.ancestral_weapon}"
    puts "Id: #{self.id}"
  end

  def self.list_all
    puts
    self.all.each_with_index do |house, index|
      puts "#{index + 1}. #{house.name}\n"
    end
  end

  def self.exists?(name)
    house = House.find_by(name:  name)
    if house
      house.print_messages
    else
      puts "That house doesn't exist!"
    end
  end
end
