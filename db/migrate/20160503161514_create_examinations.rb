class CreateExaminations < ActiveRecord::Migration
  def change
    create_table :examinations do |t|
      t.decimal :weight
      t.decimal :height
      t.integer :bp_systolic
      t.integer :pulse
      t.text :drug_allergy
      t.text :note
      t.text :exam_pi
      t.text :exam_pe
      t.text :exam_note

      t.timestamps null: false
    end
  end
end
