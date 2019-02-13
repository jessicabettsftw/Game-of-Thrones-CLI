class Event < ActiveRecord::Base
  has_many :character_events
  has_many :characters, through: :character_events
end
