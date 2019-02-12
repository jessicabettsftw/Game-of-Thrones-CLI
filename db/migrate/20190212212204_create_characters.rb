class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :house_id
      t.string :culture
      t.string :title
    end
  end
end
