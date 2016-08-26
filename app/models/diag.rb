class Diag < ActiveRecord::Base 

  ID_PREFIX = "DI"
  
  paginates_per 10

  has_many :patient_diags
  has_many :exams, through: :patient_diags

end
