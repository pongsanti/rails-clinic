class CreateDrugMovements < ActiveRecord::Migration
  def change
    create_table :drug_movements do |t|
      t.decimal :balance
      t.decimal :prev_bal
      t.string :note
      t.references :drug_in, index: true, foreign_key: true
      t.references :exam, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
