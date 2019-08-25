class ChangeIssueTypesToArray < ActiveRecord::Migration[5.2]
  def self.up
    add_column :issues, :types_temp, :string, array: true
    Issue.serialize :types, String
    Issue.serialize :types_temp, Array
    Issue.find_each do |issue|
      issue.types_temp = [issue.types]
      issue.save!
    end
    remove_column :issues, :types
    rename_column :issues, :types_temp, :types
  end

  def self.down
    add_column :issues, :types_temp, :string
    Issue.find_each do |issue|
      issue.types_temp = issue.types[0] || ""
      issue.save!
    end
    remove_column :issues, :types
    rename_column :issues, :types_temp, :types
  end
end
