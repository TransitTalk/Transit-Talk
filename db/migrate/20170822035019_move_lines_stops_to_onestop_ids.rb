class MoveLinesStopsToOnestopIds < ActiveRecord::Migration[5.0]
  def change
    rename_column :lines_stops, :line_id, :line_onestop_id
    change_column :lines_stops, :line_onestop_id, :string # Move to string

    rename_column :lines_stops, :stop_id, :stop_onestop_id
    change_column :lines_stops, :stop_onestop_id, :string # Move to string
  end
end
