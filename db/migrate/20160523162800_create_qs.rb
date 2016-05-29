class CreateQs < ActiveRecord::Migration
  def change
    create_table :qs do |t|
      t.string :category
      t.references :exam, index:true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
