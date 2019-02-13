class Character < ActiveRecord::Base
  belongs_to :house
  has_many :character_events
  has_many :events, through: :character_events
end
