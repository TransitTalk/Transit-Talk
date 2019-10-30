class AddServicedByToStops < ActiveRecord::Migration[5.2]
  def change
    add_column :stops, :serviced_by, :string
  end
end
