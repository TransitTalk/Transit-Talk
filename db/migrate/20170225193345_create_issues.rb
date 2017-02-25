class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.integer :type
      t.references :stop
      t.references :vehicle
      t.text :description
      t.references :user
    end
  end
end
