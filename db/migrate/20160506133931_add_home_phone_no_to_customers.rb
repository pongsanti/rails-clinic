class AddHomePhoneNoToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :home_phone_no, :string
  end
end
