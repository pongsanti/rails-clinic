class CreateDrugIns < ActiveRecord::Migration
  def change
    create_table :drug_ins do |t|
      t.integer :amount
      t.date :expired_date
      t.decimal :cost, precision: 8, scale: 2
      t.decimal :sale_price_per_unit, precision: 8, scale: 2
      t.integer :balance
      t.references :drug, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end