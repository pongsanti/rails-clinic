class QsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_exam, only: [:create]
  before_action :set_q, only: [:destroy, :switch_category, :activate]
  
  def index
    @q = Q.eager_cat_is(Q::EXAM_Q_CAT).ransack(params[:q])
    @exQs = @q.result.page

    @q = Q.eager_cat_is(Q::MED_Q_CAT).ransack(params[:q])
    @medQs = @q.result.page
  end

  def create
    q = Q.new
    q.active = false
    q.category = Q::EXAM_Q_CAT
    q.exam = @exam
    q.save
  end

  def activate
    # Deactivate other all of the same kind
    Q.cat_is(@q.category).where("qs.id != ?", @q).update_all(active: false)
    @q.active = true
    @q.save

    case @q.category
    when Q::EXAM_Q_CAT
      redirect_to exam_url(@q.exam)
    when Q::MED_Q_CAT
      redirect_to exam_med_url(@q.exam)
    else
      nil
    end
  end

  def switch_category
    @q.switch_category
    @q.active = false
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