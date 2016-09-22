class PatientDrug < ActiveRecord::Base

  ID_PREFIX = "PD"

  belongs_to :exam, inverse_of: :patient_drugs
  has_one :drug_movement

  belongs_to :drug_in
  belongs_to :drug_usage

  validates :exam, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 0}
  validates :revenue, numericality: {greater_than_or_equal_to: 0, allow_blank: true}


end
