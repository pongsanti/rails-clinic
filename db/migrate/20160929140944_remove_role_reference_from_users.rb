class RemoveRoleReferenceFromUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :role, index: true, foreign_key: true
  end
end
