class CreatePatientDrugs < ActiveRecord::Migration
  def change
    create_table :patient_drugs do |t|
      t.references :exam, index: true, foreign_key: true
      t.references :drug_in, index: true, foreign_key: true
      t.references :drug_usage, index: true, foreign_key: true
      t.decimal :amount, precision: 4, scale: 1
      t.decimal :revenue, precision: 9, scale: 2

      t.timestamps null: false
    end
  end
end
