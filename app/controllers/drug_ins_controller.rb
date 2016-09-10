class DrugInsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_drug_in, only: [:show, :edit, :update, :destroy]
  before_action :set_drug_from_drug_in, only: [:show, :edit, :update]
  before_action :set_drug, only: [:index, :new]
  before_action :set_holder, only: [:index]
  before_action :set_ransack_param, only: [:index, :new, :edit, :create, :update]

  def index
    @drug_ins = @q.result.page params[:page]
  end

  # GET /drug_ins/1
  # GET /drug_ins/1.json
  def show
  end

  def new
    @drug_in = DrugIn.new
  end

  # GET /drug_ins/1/edit
  def edit
  end

  def create
    @drug = Drug.find params[:drug_id]
    @drug_in = @drug.drug_ins.build(drug_in_params_create)
    
    #@amount = Amount.new(amount: params[:amount])
    #render :new and return unless @amount.valid?

    @drug_in.create_movement_for_new_drug_in

    respond_to do |format|
      if @drug_in.save

        @drug.recal_balance
        format.html { redirect_to drug_in_drug_movements_url(@drug_in), notice: 'Drug in was successfully created.' }
        format.json { render :show, status: :created, location: @drug_in }
      else
        format.html { render :new }
        format.json { render json: @drug_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drug_ins/1
  # PATCH/PUT /drug_ins/1.json
  def update
    respond_to do |format|
      if @drug_in.update(drug_in_params_update)
        format.html { redirect_to drug_in_drug_movements_url(@drug_in), notice: 'Drug in was successfully updated.' }
        format.json { render :show, status: :ok, location: @drug_in }
      else
        format.html { render :edit }
        format.json { render json: @drug_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drug_ins/1
  def destroy
    @drug_in.destroy
    respond_to do |format|
      format.html { redirect_to drug_ins_url, notice: 'Drug in was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_ransack_param
      ransack_params = {for_drug: @drug}
      ransack_params = ransack_params.merge(params[:q]) if params[:q]

      @q = DrugIn.ransack ransack_params
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

    def set_holder
      @holder = params[:holder]
    end
end
