class AddExtraTransitLandDataToLines < ActiveRecord::Migration[5.0]
  def change
    add_column :lines, :vehicle_type, :string
    add_column :lines, :wheelchair_accessible, :string
    add_column :lines, :bikes_allowed, :string
    rename_column :lines, :api_id, :route_long_name
  end
end
