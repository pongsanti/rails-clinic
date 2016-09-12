class AddDeletedAtToDrugIns < ActiveRecord::Migration
  def change
    add_column :drug_ins, :deleted_at, :datetime
    add_index :drug_ins, :deleted_at
  end
end
