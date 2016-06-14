class ExamsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :retrieve_exam, only: [:show, :edit, :update,
    :new_exam_diag, :create_exam_diag]
  before_action :retrieve_customer, only: [:index, :new, :create]
  before_action :retreive_diags, only: [:new, :edit, :new_exam_diag, :edit_exam_diag]

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

  def new_exam_diag
    @exams_diag = @exam.exams_diags.build
  end

  def create_exam_diag
    @exam.update exam_params
  end

  def edit_exam_diag
    @exams_diag = ExamsDiag.find(params[:id])
  end

  private
    def exam_params
      params.require(:exam).permit( 
        :weight, :height, 
        :bp_systolic, :bp_diastolic, 
        :pulse, :drug_allergy,
        :note,
        exams_diags_attributes: [:id, :order, :diag_id, :note, :_destroy])
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
