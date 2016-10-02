class AddSubdomainToClients < ActiveRecord::Migration
  def change
    add_column :clients, :subdomain, :string
  end
end
