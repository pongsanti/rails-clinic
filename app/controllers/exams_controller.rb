class ExamsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :retrieve_exam, only: [:show, :edit, :update, :new_exam_diag, :create_exam_diag, :update_exam_diag]
  before_action :retrieve_customer, only: [:index, :new, :create]
  before_action :retreive_diags, only: [:new, :edit, :new_exam_diag, :edit_exam_diag]

  def index
    @exams = Exam.customer_id_is(@customer.id).order("created_at desc")
    @exams = @exams.page(params[:page])
  end

  def show
    @customer = @exam.customer
  end

  def new
    @exam = Exam.new
  end

  def edit
    @customer = @exam.customer
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
    render "exams/diags/new_exam_diag"
  end

  def create_exam_diag
    if @exam.update exam_params
      render "exams/diags/diags_list"
    else
      handle_error_and_render "exams/diags/new_exam_diag"
    end
  end

  def edit_exam_diag
    @exams_diag = ExamsDiag.find(params[:id])
    render "exams/diags/edit_exam_diag"
  end

  def update_exam_diag
    if @exam.update exam_params
      render "exams/diags/diags_list"
    else
      handle_error_and_render "exams/diags/edit_exam_diag"
    end
  end

  private
    def exam_params
      params.require(:exam).permit( 
        :weight, :height, 
        :bp_systolic, :bp_diastolic, 
        :pulse, :drug_allergy,
        :note,
        exams_diags_attributes: [:id, :diag_id, :note, :_destroy])
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

    def retreive_exams_diags_when_error
      for ed in @exam.exams_diags
        @exams_diag = ed if not ed.valid?
      end
    end

    def handle_error_and_render template
      retreive_diags
      retreive_exams_diags_when_error
      render template
    end
end
