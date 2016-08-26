class AddDeletedAtToDiags < ActiveRecord::Migration
  def change
    add_column :diags, :deleted_at, :datetime
    add_index :diags, :deleted_at
  end
end
