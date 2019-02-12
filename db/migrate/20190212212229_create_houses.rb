class CreateHouses < ActiveRecord::Migration[5.0]
  def change
    create_table :houses do |t|
      t.integer :region_id
      t.string :coat_of_arms
      t.string :ancestral_weapon
      t.string :name
    end
  end
end
