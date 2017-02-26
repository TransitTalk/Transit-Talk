class AddLineToIssue < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :line_id, :integer
  end
end
