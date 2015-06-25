# Public: This class adds the role column to tthe users table and sets a default
#         of standard for it
class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'standard'
  end
end
