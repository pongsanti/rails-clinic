class DrugInsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_drug_in, only: [:show, :edit, :update, :destroy]

  before_action :set_drug_from_drug_in, only: [:show, :edit, :update]
  before_action :set_drug, only: [:index, :new]

  before_action :set_ransack_param, only: [:index, :new, :edit, :create, :update]
 
  #bc
  add_breadcrumb bc(:list, Drug), :drugs_path
  before_action :set_bc, only: [:index, :new, :edit]

  def index
    @drug_ins = @q.result.page params[:page]
  end

  def new
    add_bc :new, new_drug_drug_in_path(@drug)
    @drug_in = DrugIn.new
  end

  # GET /drug_ins/1/edit
  def edit
    add_breadcrumb bc(:list, DrugMovement), drug_in_drug_movements_path(@drug_in)
    add_bc :edit, edit_drug_in_path(@drug_in)
  end

  def create
    @drug = Drug.find params[:drug_id]
    @drug_in = @drug.drug_ins.build(drug_in_params_create)
    @drug_in.create_movement_for_new_drug_in

    if @drug_in.save
      @drug.recal_balance
      redirect_to drug_in_drug_movements_url(@drug_in), notice: t("successfully_created")
    else
      render :new
    end
  end

  # PATCH/PUT /drug_ins/1
  def update
    if @drug_in.update(drug_in_params_update)
      redirect_to drug_in_drug_movements_url(@drug_in), notice: t("successfully_updated")
    else
      render :edit
    end
  end

  # DELETE /drug_ins/1
  def destroy
    @drug = @drug_in.drug
    @drug_in.destroy
    redirect_to drug_drug_ins_url(@drug), notice: t("successfully_destroyed")
  end

  private
    def set_ransack_param
      @q = DrugIn.for_drug(@drug).ransack(params[:q])
      @q.sorts = "id desc" if @q.sorts.empty?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_drug_in
      @drug_in = DrugIn.find(params[:id])
    end

    def set_drug
      @drug = Drug.find params[:drug_id]
    end

    def set_drug_from_drug_in
      @drug = @drug_in.drug
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drug_in_params_create
      params.require(:drug_in).permit(:amount, :expired_date, :cost, :sale_price_per_unit)
    end

    def drug_in_params_update
      params.require(:drug_in).permit(:expired_date, :cost, :sale_price_per_unit)
    end

    def add_bc(key, path)
      add_breadcrumb bc(key, DrugIn), path
    end

    def set_bc
      add_breadcrumb bc(:show, Drug), drug_path(@drug)
      add_bc :list, drug_drug_ins_path(@drug)
    end
end
