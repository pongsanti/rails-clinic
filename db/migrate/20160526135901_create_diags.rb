class CreateDiags < ActiveRecord::Migration
  def change
    create_table :diags do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end

    create_table :exams_diags do |t|
      t.belongs_to :exam, index: true, foreign_key: true
      t.belongs_to :diag, index: true, foreign_key: true
      t.integer :order
      t.string :note

      t.timestamps null: false
    end

  end
end
