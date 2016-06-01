class RemovePhaseFromExams < ActiveRecord::Migration
  def change
    remove_column :exams, :phase, :string
  end
end
