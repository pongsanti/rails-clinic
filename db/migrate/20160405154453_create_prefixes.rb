class CreatePrefixes < ActiveRecord::Migration
  def change
    create_table :prefixes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
