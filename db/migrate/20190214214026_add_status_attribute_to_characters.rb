class AddStatusAttributeToCharacters < ActiveRecord::Migration[5.2]
  def change

    add_column :characters, :status, :string
  end
end
