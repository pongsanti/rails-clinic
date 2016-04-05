class AddPrefixRefToCustomers < ActiveRecord::Migration
  def change
    add_reference :customers, :prefix, index: true, foreign_key: true
  end
end
