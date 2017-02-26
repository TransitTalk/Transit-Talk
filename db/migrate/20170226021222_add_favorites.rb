class AddFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :stops_users do |t|
      t.references :user
      t.references :stop
    end

    add_column :lines, :color, :string
  end
end
