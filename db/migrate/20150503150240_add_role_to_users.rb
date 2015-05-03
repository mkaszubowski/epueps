class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, default: 0
    remove_column :users, :admin, :boolean
  end
end
