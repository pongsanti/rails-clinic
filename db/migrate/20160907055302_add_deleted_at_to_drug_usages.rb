class AddDeletedAtToDrugUsages < ActiveRecord::Migration
  def change
    add_column :drug_usages, :deleted_at, :datetime
    add_index :drug_usages, :deleted_at
  end
end
