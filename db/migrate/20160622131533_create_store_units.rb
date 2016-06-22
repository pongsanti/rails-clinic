class CreateStoreUnits < ActiveRecord::Migration
  def change
    create_table :store_units do |t|
      t.string :title

      t.timestamps null: false
    end

    add_reference :drugs, :store_unit, index: true, foreign_key: true
  end
end
