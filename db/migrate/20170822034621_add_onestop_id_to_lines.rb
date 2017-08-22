class AddOnestopIdToLines < ActiveRecord::Migration[5.0]
  def change
    add_column :lines, :onestop_id, :string
    add_index :lines, :onestop_id
  end
end
