class ExamsDiagsController < ApplicationController
  
  def index_by_exam
    @exams_diags = ExamsDiag.find_by_exam_id(params[:exam_id])
    render json: @exams_diags  
  end
end