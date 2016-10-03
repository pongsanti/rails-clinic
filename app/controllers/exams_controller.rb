class ExamsController < ApplicationController
  
  #bc
  add_breadcrumb bc(:list, Customer), :customers_path

  before_action :authenticate_user!
  before_action :set_exam, only: [
    :show, :show_med, :show_drugs, :show_appointments,

    :edit_weight, :edit_pe, :edit_diag, :edit_drug,
    :edit_revenue, :edit_appointment,

    :update_weight, :update_pe, :update_diag, :update_drug,
    :update_revenue, :update_appointment,
    :pay,
    
    :destroy,
    :new_patient_diag, :create_patient_diag, :update_patient_diag]
  before_action :set_customer, only: [:index, :new_weight, :create_weight]
  before_action :set_customer_from_exam, only: [
    :show, :show_med, :show_drugs, :show_appointments,
    
    :edit_weight, :edit_pe, :edit_diag, :edit_drug,
    :edit_revenue, :edit_appointment,
    
    :update_weight, :update_pe, :update_diag, :update_drug,
    :update_revenue, :update_appointment,
    :pay ]

  before_action :set_diags, only: [:edit_diag, :new_patient_diag, :edit_patient_diag]

  before_action :set_user, only: [:update_weight, :update_pe, :update_diag,
      :update_drug, :update_revenue, :update_appointment ]

  before_action :set_bc, only: [:index, :show, :show_med,
    :new_weight,
    :edit_weight, :edit_pe, :edit_diag,
    :edit_drug, :edit_revenue, :edit_appointment]

  def index
    @q = Exam.for_customer(@customer.id).ransack(params[:q])
    @q.sorts = "id asc" if @q.sorts.empty?

    @exams = @q.result.page(params[:page])
  end

  def show
    add_bc :show, exam_path(@exam)
  end

  def show_med
    add_bc :show, exam_path(@exam)
    add_breadcrumb I18n.t("bc.exam_med"), exam_med_path(@exam)
    render "exams/show_med/show"
  end

  def show_drugs
    @drugs = @exam.patient_drugs
    respond_to do |format|
      format.pdf {
        render pdf: "exam_drug_#{@exam.id}", template: "exams/drugs/show",
          page_height: "46mm", page_width: "80mm",
          margin: { top: 10, bottom: 0 },
          show_as_html: params.key?('debug')
      }
    end
  end

  def show_appointments
    @appointments = @exam.appointments
    respond_to do |format|
      format.pdf {
        render pdf: "exam_app_#{@exam.id}", template: "exams/appointment/show",
          page_height: "46mm", page_width: "80mm",
          margin: { top: 10, bottom: 0 },
          show_as_html: params.key?('debug')
      }
    end
  end

  def new_weight
    add_bc :new, new_customer_exam_weight_path(@customer)
    @exam = Exam.new
  end

  def edit_weight
    set_edit_bc edit_exam_weight_path(@exam)
  end

  def edit_pe
    set_edit_bc edit_exam_pe_path(@exam)
  end

  def edit_diag
    set_edit_bc edit_exam_diag_path(@exam)
  end

  def edit_drug
    set_edit_bc edit_exam_drug_path(@exam)
    set_objects_for_edit
  end

  def edit_revenue
    set_edit_bc edit_exam_revenue_path(@exam)
    render "exams/revenue/edit"
  end

  def edit_appointment
    set_edit_bc edit_exam_appointment_path(@exam) 
    render "exams/appointment/edit"
  end

  def create_weight
    @exam = Exam.new(exam_weight_params)
    @exam.revenue = 100.00
    set_user
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
      set_objects_for_edit
      render "edit_drug"
    end
  end

  def update_revenue
    if @exam.update(exam_revenue_params)
      redirect_to exam_url(@exam), notice: t('successfully_updated')
    else
      render "exams/revenue/edit"
    end
  end

  def update_appointment
    if @exam.update(exam_appointment_params)
      redirect_to exam_url(@exam), notice: t('successfully_updated')
    else
      render "exams/appointment/edit"
    end
  end

  def pay
    @exam.pay
    redirect_to exam_med_url(@exam), notice: t('successfully_updated')
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

    def exam_revenue_params
      params.require(:exam).permit(:revenue)
    end

    def exam_appointment_params
      params.require(:exam).permit(
        appointments_attributes: [:id, :date, :time, :note, :_destroy]
      )
    end

    def set_user
      @exam.examiner = current_user
    end

    def set_exam
      @exam = Exam.eager.find(params[:id])
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

    def set_objects_for_edit
      @drug_ins = DrugIn.includes(:drug)
      @drug_usages = DrugUsage.all
    end

    def add_bc(key, path)
      add_breadcrumb bc(key, Exam), path
    end

    def set_bc
      add_breadcrumb bc(:show, Customer), customer_path(@customer)
      add_bc :list, customer_exams_path(@customer)
    end

    def set_edit_bc(path)
      add_bc :show, exam_path(@exam)
      add_bc :edit, path
    end
end
