class ExamsDiagsController < ApplicationController
  
  before_action :authenticate_user!

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

  def create
    @exam = Exam.find params[:exam_id]
    Exam.transaction do
      # remove all associations
      @exam.exams_diags.each do |ed|
        ed.destroy!
      end

      # create new associations
      params[:exams_diags].each do |k, v|
        ed = ExamsDiag.new
        ed.exam = @exam
        ed.diag = Diag.find(v["diag_id"])
        ed.order = v["order"]
        ed.note = v["note"]
        ed.save!
      end
    end
    #render plain: params[:exams_diags].inspect
    render plain: params.inspect
  end
end