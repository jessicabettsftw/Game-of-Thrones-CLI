class Murder < ActiveRecord::Base
  belongs_to :murderer, :class_name => "Character"
  belongs_to :victim, :class_name => "Character"
end
