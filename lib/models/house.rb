class House < ActiveRecord::Base
  has_many :characters
  belongs_to :region

  def print_messages
    puts "Region: #{self.region.name}"
    puts "Coat of Arms: #{self.coat_of_arms}"
    puts "Ancestral Weapon: #{self.ancestral_weapon}"
    puts "Id: #{self.id}"
  end
end
