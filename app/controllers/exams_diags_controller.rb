class ExamsDiagsController < ApplicationController
  
  def index_by_exam
    @exam = Exam.find params[:exam_id]

    if @exam != nil
      @exams_diags = @exam.exams_diags
      if @exams_diags != nil
        render json: @exams_diags and return
      end
    end
  
    render json: { "exams_diag": [] }
  end
end