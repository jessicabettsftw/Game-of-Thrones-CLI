class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :region_id
      t.string :date
      t.string :name
    end
  end
end
