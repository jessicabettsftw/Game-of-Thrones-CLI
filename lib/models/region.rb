class Region < ActiveRecord::Base
  has_many :houses
  has_many :events
end
