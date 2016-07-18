class DrugUsagesController < ApplicationController
  
  before_action :authenticate_user!  
  before_action :set_drug_usage, only: [:show, :edit, :update, :destroy]

  # GET /drug_usages
  # GET /drug_usages.json
  def index
    @q = DrugUsage.ransack params[:q]
    @drug_usages = @q.result.page params[:page]
  end

  # GET /drug_usages/1
  # GET /drug_usages/1.json
  def show
  end

  # GET /drug_usages/new
  def new
    @drug_usage = DrugUsage.new
  end

  # GET /drug_usages/1/edit
  def edit
  end

  # POST /drug_usages
  # POST /drug_usages.json
  def create
    @drug_usage = DrugUsage.new(drug_usage_params)

    respond_to do |format|
      if @drug_usage.save
        format.html { redirect_to @drug_usage, notice: 'Drug usage was successfully created.' }
        format.json { render :show, status: :created, location: @drug_usage }
      else
        format.html { render :new }
        format.json { render json: @drug_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drug_usages/1
  # PATCH/PUT /drug_usages/1.json
  def update
    respond_to do |format|
      if @drug_usage.update(drug_usage_params)
        format.html { redirect_to @drug_usage, notice: 'Drug usage was successfully updated.' }
        format.json { render :show, status: :ok, location: @drug_usage }
      else
        format.html { render :edit }
        format.json { render json: @drug_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drug_usages/1
  # DELETE /drug_usages/1.json
  def destroy
    @drug_usage.destroy
    respond_to do |format|
      format.html { redirect_to drug_usages_url, notice: 'Drug usage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drug_usage
      @drug_usage = DrugUsage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drug_usage_params
      params.require(:drug_usage).permit(:code, :text, :times_per_day, :use_amount)
    end
end
