class ChangeStopLatitudeLongitude < ActiveRecord::Migration[5.0]
  def change
  	  change_column :stops, :lattitude, :decimal, :precision => 10, :scale => 2
   change_column :stops, :longitude, :decimal, :precision => 10, :scale => 2
  end
end
