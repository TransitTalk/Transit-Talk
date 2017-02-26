class IssuesAddBoolean < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :resolved, :boolean
  end
end
