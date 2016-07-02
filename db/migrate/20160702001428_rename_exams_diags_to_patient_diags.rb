class RenameExamsDiagsToPatientDiags < ActiveRecord::Migration
  def change
    rename_table :exams_diags, :patient_diags
  end
end
