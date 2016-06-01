class ExamsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :retrieve_customer, only: [:index, :new, :create]

  def index
    @exams = Exam.customer_id_is(@customer.id).order("created_at desc")
  end

  def index_poll
    #@exams = Exam.where("created_at >= ?", Time.zone.now.beginning_of_day).order("created_at desc")
    @exams = Exam.created_after(Time.zone.now.beginning_of_day)
    @exams = @exams.phase_is('W').order("created_at desc")
    render json: @exams
  end

  def show
    @exam = Exam.find(params[:id])
  end

  def new
    @exam = Exam.new
    @exam.customer = @customer
  end

  def edit
  end

  def create
    @exam = Exam.new(exams_params)
    @exam.phase = 'W'
    @exam.customer = @customer
    
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
      params.require(:exam).permit( 
        :weight, :height, 
        :bp_systolic, :bp_diastolic, 
        :pulse, :drug_allergy,
        :note)
    end

    def retrieve_customer
      @customer = Customer.find(params[:customer_id])
    end
end
