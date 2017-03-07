class UpdateStopLatLongScale < ActiveRecord::Migration[5.0]
  def change
   change_column :stops, :lattitude, :decimal, :precision => 12, :scale => 8
   change_column :stops, :longitude, :decimal, :precision => 12, :scale => 8
  end
end
