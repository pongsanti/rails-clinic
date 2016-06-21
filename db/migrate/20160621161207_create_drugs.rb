class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.text :name
      t.text :trade_name
      t.text :effect
      t.decimal :balance
      t.references :drug_usage, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
