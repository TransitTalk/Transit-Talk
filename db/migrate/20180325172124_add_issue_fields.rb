class AddIssueFields < ActiveRecord::Migration[5.0]
  def change
  	remove_column :issues, :types, :integer
    add_column :issues, :location_type, :string
    add_column :issues, :direction, :string
    add_column :issues, :reported_at, :datetime
    add_column :issues, :issue_type, :string
    add_column :issues, :notified, :boolean
    add_column :issues, :alt_transport, :boolean
    add_column :issues, :cta_contact, :boolean
  end
end
