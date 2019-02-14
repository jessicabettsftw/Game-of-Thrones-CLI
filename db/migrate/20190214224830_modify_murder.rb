class ModifyMurder < ActiveRecord::Migration[5.2]
  def change
    rename_column :murders, :murderee_id, :victim_id
  end
end
