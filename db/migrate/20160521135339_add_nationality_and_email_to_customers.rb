class AddNationalityAndEmailToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :nationality, :string
    add_column :customers, :email, :string
  end
end
