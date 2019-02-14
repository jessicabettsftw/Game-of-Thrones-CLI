class CreateMurders < ActiveRecord::Migration[5.2]
  def change
    create_table :murders do |column|
      column.integer :murderer_id
      column.integer :murderee_id
    end
  end
end
