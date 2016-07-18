class ExamsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_exam, only: [:show, :edit, :update, :new_patient_diag, :create_patient_diag, :update_patient_diag]
  before_action :set_customer, only: [:index, :new, :create]
  before_action :assign_customer_from_exam, only: [:show, :edit, :update]
  before_action :set_diags, only: [:new, :edit, :new_patient_diag, :edit_patient_diag]
  before_action :set_drugs, only: [:edit]

  def index
    ransack_params = {for_customer: @customer.id}
    ransack_params = ransack_params.merge(params[:q]) if params[:q]

    @q = Exam.ransack(ransack_params)
    @exams = @q.result.page(params[:page])
  end

  def show
  end

  def new
    @exam = Exam.new
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
      if params[:submit_and_stay]
        flash.now[params[:section]] = "update_success" 
        render 'edit'
      else
        redirect_to @exam
      end
    else
      render 'edit'
    end
  end

  def destroy
  end

  def new_patient_diag
    @patient_diag = @exam.patient_diags.build
    render "exams/diags/new_patient_diag"
  end

  def create_patient_diag
    if @exam.update exam_params
      @patient_diags_id = PatientDiag.latest(@exam.id).id
      render "exams/diags/diags_list"
    else
      handle_error_and_render "exams/diags/new_patient_diag"
    end
  end

  def edit_patient_diag
    @patient_diag = PatientDiag.find(params[:id])
    render "exams/diags/edit_patient_diag"
  end

  def update_patient_diag
    if @exam.update exam_params
      @patient_diags_id = exam_params[:patient_diags_attributes]["0"][:id].to_i
      render "exams/diags/diags_list"
    else
      handle_error_and_render "exams/diags/edit_patient_diag"
    end
  end

  private
    def exam_params
      params.require(:exam).permit( 
        :weight, :height, 
        :bp_systolic, :bp_diastolic, 
        :pulse, :drug_allergy,
        :note,
        # weight_form
        :exam_pi, :exam_pe, :exam_note,
        # patient_diags
        patient_diags_attributes: [:id, :diag_id, :note, :_destroy])
    end

    def set_exam
      @exam = Exam.find(params[:id])
    end

    def assign_customer_from_exam
      @customer = @exam.customer
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def set_diags
      @diags = Diag.all
    end

    def set_drugs
      @drugs = Drug.drug_ins_exist
    end

    def set_patient_diags_when_error
      for pd in @exam.patient_diags
        @patient_diag = pd if not pd.valid?
      end
    end

    def handle_error_and_render template
      set_diags
      set_patient_diags_when_error
      render template
    end
end
