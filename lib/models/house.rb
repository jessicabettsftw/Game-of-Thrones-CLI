class House < ActiveRecord::Base
  has_many :characters
  belongs_to :region
end
