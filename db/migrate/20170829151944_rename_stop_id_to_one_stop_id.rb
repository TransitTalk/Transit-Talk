class RenameStopIdToOneStopId < ActiveRecord::Migration[5.0]
  def change
    rename_column :stops_users, :stop_id, :stop_onestop_id
    change_column :stops_users, :stop_onestop_id, :string # Move to string

    rename_column :issues, :stop_id, :stop_onestop_id
    change_column :issues, :stop_onestop_id, :string # Move to string

    rename_column :issues, :line_id, :line_onestop_id
    change_column :issues, :line_onestop_id, :string # Move to string
  end
end
