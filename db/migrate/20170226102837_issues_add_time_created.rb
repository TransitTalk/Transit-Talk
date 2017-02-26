class IssuesAddTimeCreated < ActiveRecord::Migration[5.0]
      add_column(:issues, :created_at, :datetime)
      add_column(:issues, :updated_at, :datetime)
  def change
  end
end
