class IndexApiIds < ActiveRecord::Migration[5.0]
  def change
    add_index :stops, :api_id
    add_index :lines, :api_id
    add_index :vehicles, :api_id
  end
end
