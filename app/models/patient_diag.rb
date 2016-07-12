class PatientDiag < ActiveRecord::Base

  belongs_to :exam
  belongs_to :diag


  class << self
    #scope
    def latest(exam_id)
      where("exam_id = ?", exam_id).order(:id).last
    end

  end
end