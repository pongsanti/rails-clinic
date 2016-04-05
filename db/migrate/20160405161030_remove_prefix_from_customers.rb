class RemovePrefixFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :prefix, :string
  end
end
