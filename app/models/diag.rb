class Diag < ActiveRecord::Base

  has_many :patient_diags
  has_many :exams, through: :patient_diags

end
