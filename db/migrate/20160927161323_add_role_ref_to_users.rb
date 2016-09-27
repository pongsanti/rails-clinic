class AddRoleRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :role, index: true, foreign_key: true
    remove_column :users, :role, :string
  end
end
