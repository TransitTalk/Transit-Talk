class ChangeStops < ActiveRecord::Migration[5.0]
  def change
    add_column :stops, :twin_stop_id, :integer
    remove_column :stops, :direction, :string
  end
end
