class DrugMovementBelongsToPatientDrug < ActiveRecord::Migration
  def change
    remove_reference :drug_movements, :exam, index: true, foreign_key: true
    add_belongs_to :drug_movements, :patient_drug, index: true, foreign_key: true
  end
end
