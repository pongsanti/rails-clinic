class AddHstoreExtension < ActiveRecord::Migration
  
  def self.up
    execute "CREATE EXTENSION IF NOT EXISTS hstore SCHEMA public"
  end
  
  def self.down
    execute "DROP EXTENSION IF EXISTS hstore CASCADE"
  end

end