class AddIndexToCustomers < ActiveRecord::Migration
  def change
    add_index :customers, :cn, unique: true
  end
end
