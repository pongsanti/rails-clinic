class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :phase
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

    # Customer
    add_reference :exams, :customer, index: true, foreign_key: true
    # User doctor
    add_reference :exams, :examiner, references: :users, index: true
    add_foreign_key :exams, :users, column: :examiner_id

    add_index :exams, :phase
  end
end
