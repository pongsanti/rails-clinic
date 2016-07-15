class CreateDrugMovements < ActiveRecord::Migration
  def change
    create_table :drug_movements do |t|
      t.references :movable, polymorphic: true, index: true
      t.decimal :balance, precision: 8, scale: 2 
      t.decimal :previous, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
