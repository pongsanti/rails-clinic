class ExamsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :retrieve_exam, only: [:show, :edit, :update]
  before_action :retrieve_customer, only: [:index, :new, :create]
  before_action :retreive_diags, only: [:new, :edit]

  def index
    @exams = Exam.customer_id_is(@customer.id).order("created_at desc")
  end

  def show
  end

  def new
    @exam = Exam.new
    @exam.note = "note"
    @exam.customer = @customer
    @exam.exams_diags.build
  end

  def edit
  end

  def create
    @exam = Exam.new(exam_params)
    @exam.customer = @customer
    
    if @exam.save
      if params[:submit].present?
        redirect_to exam_url(@exam)
      else
        redirect_to edit_exam_url(@exam)
      end
    else
      render 'new'
    end    
  end

  def update
    if @exam.update(exam_params)
      redirect_to @exam
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def exam_params
      params.require(:exam).permit( 
        :weight, :height, 
        :bp_systolic, :bp_diastolic, 
        :pulse, :drug_allergy,
        :note,
        exams_diags_attributes: [:id, :order, :diag_id, :note])
    end

    def retrieve_exam
      @exam = Exam.find(params[:id])
    end

    def retrieve_customer
      @customer = Customer.find(params[:customer_id])
    end

    def retreive_diags
      @diags = Diag.all
    end
end
