class AddDeletedAtToDrugs < ActiveRecord::Migration
  def change
    add_column :drugs, :deleted_at, :datetime
    add_index :drugs, :deleted_at
  end
end
