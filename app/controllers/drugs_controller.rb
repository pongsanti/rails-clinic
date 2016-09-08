class DrugsController < ApplicationController
  
  before_action :authenticate_user!  
  before_action :set_drug, only: [:show, :edit, :update, :destroy]
  before_action :set_drug_usages, only: [:new, :edit]
  before_action :set_store_units, only: [:new, :edit]
  before_action :set_ransack_search_param, only: [:index, :show, :new, :edit, :create, :update]

  # GET /drugs
  def index
    @drugs = @q.result.page params[:page]
  end

  def index_has_drug_ins
    @drugs = Drug.drug_ins_exist
    render json: @drugs
  end

  # GET /drugs/1
  def show
  end

  # GET /drugs/new
  def new
    @drug = Drug.new
  end

  # GET /drugs/1/edit
  def edit
  end

  # POST /drugs
  def create
    @drug = Drug.new(drug_params)

    if @drug.save
      redirect_to @drug, notice: t("successfully_created")
    else
      set_drug_usages
      set_store_units      
      render :new
    end
  end

  # PATCH/PUT /drugs/1
  def update
    if @drug.update(drug_params)
      redirect_to @drug, notice: t("successfully_updated")
    else
      set_drug_usages
      set_store_units
      render :edit
    end
  end

  # DELETE /drugs/1
  def destroy
    @drug.destroy
    redirect_to drugs_url, notice: t("successfully_destroyed")
  end

  private
    def set_ransack_search_param
      @q = Drug.ransack(params[:q])
    end  
    # Use callbacks to share common setup or constraints between actions.
    def set_drug
      @drug = Drug.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drug_params
      params.require(:drug).permit(:name, :trade_name, :effect, :concern, :drug_usage_id, :store_unit_id)
    end

    def set_drug_usages
      @drug_usages = DrugUsage.all
    end

    def set_store_units
      @store_units = StoreUnit.all
    end
end
