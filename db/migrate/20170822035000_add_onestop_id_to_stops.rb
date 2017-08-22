class AddOnestopIdToStops < ActiveRecord::Migration[5.0]
  def change
    add_column :stops, :onestop_id, :string
    add_index :stops, :onestop_id
  end
end
