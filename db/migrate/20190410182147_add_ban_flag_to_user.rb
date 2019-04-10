class AddBanFlagToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_banned, :boolean, null: false, default: false
  end
end
