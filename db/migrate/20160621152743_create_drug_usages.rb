class CreateDrugUsages < ActiveRecord::Migration
  def change
    create_table :drug_usages do |t|
      t.string :code
      t.string :text

      t.timestamps null: false
    end
  end
end
