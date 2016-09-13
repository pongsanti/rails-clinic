class ExamsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_exam, only: [:show,

    :edit_weight, :edit_pe, :edit_diag, :edit_drug,
    :update_weight, :update_pe, :update_diag, :update_drug,
    
    :destroy,
    :new_patient_diag, :create_patient_diag, :update_patient_diag]
  before_action :set_customer, only: [:index, :new_weight, :create_weight]
  before_action :set_customer_from_exam, only: [:show,
    :edit_weight, :edit_pe, :edit_diag, :edit_drug,
    :update_weight, :update_pe, :update_diag, :update_drug ]
  before_action :set_diags, only: [:edit_diag, :new_patient_diag, :edit_patient_diag]

  def index
    ransack_params = {for_customer: @customer.id}
    ransack_params = ransack_params.merge(params[:q]) if params[:q]

    @q = Exam.ransack(ransack_params)
    @exams = @q.result.page(params[:page])
  end

  def show
  end

  def new_weight
    @exam = Exam.new
  end

  def edit_weight
  end

  def edit_pe
  end

  def edit_diag
  end

  def edit_drug
    @drug_ins = DrugIn.includes(:drug)
    @drug_usages = DrugUsage.all
  end

  def create_weight
    @exam = Exam.new(exam_weight_params)
    @exam.customer = @customer
    
    if @exam.save
      redirect_to exam_url(@exam), notice: t('successfully_created')
    else
      render 'new_weight'
    end    
  end

  def update_weight
    if @exam.update(exam_weight_params)
      redirect_to exam_url(@exam), notice: t('successfully_updated')
    else
      render 'edit_weight'
    end
  end

  def update_pe
    if @exam.update(exam_pe_params)
      redirect_to exam_url(@exam), notice: t('successfully_updated')
    else
      render 'edit_pe'
    end
  end

  def update_diag
    if @exam.update(exam_diag_params)
      redirect_to exam_url(@exam), notice: t('successfully_updated')
    else
      set_diags
      render "edit_diag"
    end
  end

  def update_drug
    if @exam.update(exam_drug_params)
      redirect_to exam_url(@exam), notice: t('successfully_updated')
    else
      @drug_ins = DrugIn.all
      @drug_usages = DrugUsage.all
      render "edit_drug"
    end
  end

  def destroy
    @exam.destroy
    redirect_to customer_exams_url(@exam.customer), notice: t("successfully_destroyed")
  end

  private
    def exam_weight_params
      params.require(:exam).permit( 
        :weight, :height, 
        :bp_systolic, :bp_diastolic, 
        :pulse, :note)
    end

    def exam_pe_params
      params.require(:exam).permit( 
        :exam_pi, :exam_pe, :exam_note)
    end

    def exam_diag_params
      params.require(:exam).permit(
        patient_diags_attributes: [:id, :diag_id, :note, :_destroy]
      )
    end

    def exam_drug_params
      params.require(:exam).permit(
        patient_drugs_attributes: [:id, :drug_in_id, :drug_usage_id, :amount, :revenue, :_destroy]
      )
    end
=begin
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
=end
    def set_exam
      @exam = Exam.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def set_customer_from_exam
      @customer = @exam.customer
    end

    def set_diags
      @diags = Diag.all
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
