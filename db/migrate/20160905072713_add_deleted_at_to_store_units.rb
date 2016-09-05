class AddDeletedAtToStoreUnits < ActiveRecord::Migration
  def change
    add_column :store_units, :deleted_at, :datetime
    add_index :store_units, :deleted_at
  end
end
