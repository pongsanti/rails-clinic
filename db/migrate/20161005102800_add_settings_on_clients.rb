class AddSettingsOnClients < ActiveRecord::Migration
  
  def up
    add_column :clients, :settings, "public.hstore"
    add_index :clients, :settings, using: :gist    
  end

  def down
    if column_exists? :clients, :settings, "public.hstore"
      remove_column :clients, :settings, "public.hstore"
    end

    if index_exists? :clients, :settings, using: :gist
      remove_index :clients, :settings
    end
  end
end
