class CreateCharacterEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :character_events do |column|
      column.integer :character_id
      column.integer :event_id
    end
  end
end
