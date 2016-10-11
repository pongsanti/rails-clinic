class PatientDiag < ActiveRecord::Base

  ID_PREFIX = "ED"
  
  belongs_to :exam, inverse_of: :patient_diags, touch: true
  belongs_to :diag, inverse_of: :patient_diags

  class << self

    def default_scope
      order("id ASC")
    end

  end
end