class PatientDrug < ActiveRecord::Base
  belongs_to :exam
  belongs_to :drug_in
  belongs_to :drug_usage
end
