class QsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_exam, only: [:create]
  before_action :set_q, only: [:destroy]

  def index
    @qs = Q.all
  end

  def create
    q = Q.new
    q.category = "B"
    q.exam = @exam
    q.save
  end

  def destroy
    @q.destroy
  end

  private
    #def qs_params
    #  params.require(:q).permit(:type)
    #end

    def set_q
      @q = Q.find(params[:id])
    end

    def set_exam
      @exam = Exam.find(params[:exam_id])
    end  

end