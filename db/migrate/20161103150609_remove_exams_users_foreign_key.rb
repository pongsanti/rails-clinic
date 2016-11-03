class RemoveExamsUsersForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key :exams, column: :examiner_id
  end
end
