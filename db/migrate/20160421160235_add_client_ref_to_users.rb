class AddClientRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :client, index: true, foreign_key: true
  end
end
