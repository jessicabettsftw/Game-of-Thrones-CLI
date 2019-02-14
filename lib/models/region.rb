class Region < ActiveRecord::Base
  has_many :houses
  has_many :events

  def print_messages
    puts "Id: #{self.id}"
  end

  def self.list_all
    puts
    self.all.each_with_index do |region, index|
      puts "#{index + 1}. #{region.name}\n"
    end
  end

  def self.exists?(name)
    region = self.find_by(name:  name)
    if region
      region.print_messages
    else
      puts "That region doesn't exist"
    end
  end
end
