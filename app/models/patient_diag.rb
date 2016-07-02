class PatientDiag < ActiveRecord::Base

  belongs_to :exam
  belongs_to :diag

end