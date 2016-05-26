class Diag < ActiveRecord::Base

  has_many :exams_diags
  has_many :exams, through: :exams_diags

end
