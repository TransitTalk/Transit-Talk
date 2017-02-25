class CreateStops < ActiveRecord::Migration[5.0]
  def change
    create_table :stops do |t|
    	t.string :api_id
    	t.string :name
    	t.string :direction
    	t.decimal :longitude
    	t.decimal :lattitude

    	
    end
  end
end
