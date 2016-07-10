class DrugInsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_drug_in, only: [:show, :edit, :update, :destroy]
  before_action :set_drug_from_drug_in, only: [:show]
  before_action :set_drug, only: [:index, :new]

  # GET /drug_ins
  # GET /drug_ins.json
  def index
    ransack_params = {for_drug: @drug}
    ransack_params = ransack_params.merge(params[:q]) if params[:q]

    @q = DrugIn.ransack ransack_params
    @drug_ins = @q.result.page params[:page]
  end

  # GET /drug_ins/1
  # GET /drug_ins/1.json
  def show
  end

  # GET /drug_ins/new
  def new
    @drug_in = DrugIn.new
  end

  # GET /drug_ins/1/edit
  def edit
  end

  # POST /drug_ins
  # POST /drug_ins.json
  def create
    @drug = Drug.find params[:drug_id]
    @drug_in = @drug.drug_ins.build(drug_in_params)

    respond_to do |format|
      if @drug_in.save
        
        format.html { redirect_to @drug_in, notice: 'Drug in was successfully created.' }
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
      if @drug_in.update(drug_in_params)
        format.html { redirect_to @drug_in, notice: 'Drug in was successfully updated.' }
        format.json { render :show, status: :ok, location: @drug_in }
      else
        format.html { render :edit }
        format.json { render json: @drug_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drug_ins/1
  # DELETE /drug_ins/1.json
  def destroy
    @drug_in.destroy
    respond_to do |format|
      format.html { redirect_to drug_ins_url, notice: 'Drug in was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
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
    def drug_in_params
      params.require(:drug_in).permit(:amount, :expired_date, :cost, :sale_price_per_unit, :balance, :drug_id)
    end
end
