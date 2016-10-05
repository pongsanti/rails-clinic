class AddSettingsOnClients < ActiveRecord::Migration
  def change
    add_column :clients, :settings, :hstore
    add_index :clients, :settings, using: :gist    
  end
end
