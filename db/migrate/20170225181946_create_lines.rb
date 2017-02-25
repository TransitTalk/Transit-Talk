class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
      t.string :api_id
      t.string :name
      t.integer :system_type
    end
    create_table :lines_stops do |t|
      t.references :stop
      t.references :line
    end
  end
end
