class ChangeIssues < ActiveRecord::Migration[5.0]
  def change
    remove_column :issues, :type, :integer
    add_column :issues, :types, :string
  end
end
