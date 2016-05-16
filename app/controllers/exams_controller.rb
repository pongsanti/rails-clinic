class ExamsController < ApplicationController
  
  before_action :authenticate_user!

  def index
  end

  def index_poll
    @exams = Exam.where("created_at >= ?", Time.zone.now.beginning_of_day).order("created_at desc")
    render json: @exams
  end

  def show
    @exam = Exam.find(params[:id])
  end

  def new
    @exam = Exam.new
    retrieve_customer
  end

  def edit
  end

  def create
    @exam = Exam.new(exams_params)
    retrieve_customer
    
    if @exam.save
      redirect_to exam_url(@exam)
    else
      render 'new'
    end    
  end

  def update
  end

  def destroy
  end

  private
    def exams_params
      params.require(:exam).permit(:phase, 
        :weight, :height, 
        :bp_systolic, :bp_diastolic, 
        :pulse, :drug_allergy,
        :note)
    end

    def retrieve_customer
      @customer = Customer.find(params[:customer_id])
      @exam.customer = @customer
    end
end
