class QsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @qs = Q.all
  end

  def index_poll
    @qs = Q.cat_is('W')
    render json: @qs
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @q = Q.new
    @q.category = 'W'
    retrieve_exam
    
    @q.save
    redirect_to :back
  end

  def update
  end

  def destroy
    @q = Q.find(params[:id])
    @q.destroy

    redirect_to :back
  end

  private
    #def qs_params
    #  params.require(:q).permit(:type)
    #end

    def retrieve_exam
      @exam = Exam.find(params[:exam_id])
      @q.exam = @exam
    end  

end