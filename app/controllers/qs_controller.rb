class QsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_exam, only: [:create]
  before_action :set_q, only: [:destroy, :switch_category]
  
  def index
    @exQs = Q.cat_is(Q::EXAM_Q_CAT)
    @medQs = Q.cat_is(Q::MED_Q_CAT)
  end

  def create
    q = Q.new
    q.category = Q::EXAM_Q_CAT
    q.exam = @exam
    q.save
  end

  def switch_category
    @q.switch_category
    @q.save
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