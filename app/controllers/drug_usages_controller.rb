class DrugUsagesController < ApplicationController
  
  before_action :authenticate_user!  
  before_action :set_drug_usage, only: [:show, :edit, :update, :destroy]
  before_action :set_ransack_search_param, only: [:index, :show, :new, :edit, :update, :create]

  # GET /drug_usages
  def index
    @drug_usages = @q.result.page params[:page]
  end

  # GET /drug_usages/1
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
  def create
    @drug_usage = DrugUsage.new(drug_usage_params)

    if @drug_usage.save
      redirect_to @drug_usage, notice: t("successfully_created")
    else
      render :new
    end
  end

  # PATCH/PUT /drug_usages/1
  def update
    if @drug_usage.update(drug_usage_params)
      redirect_to @drug_usage, notice: t("successfully_updated")
    else
      render :edit
    end
  end

  # DELETE /drug_usages/1
  def destroy
    @drug_usage.destroy
    redirect_to drug_usages_url, notice: t("successfully_destroyed")
  end

  private
    def set_ransack_search_param
      @q = DrugUsage.ransack(params[:q])
      @q.sorts = "id asc" if @q.sorts.empty?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_drug_usage
      @drug_usage = DrugUsage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drug_usage_params
      params.require(:drug_usage).permit(:code, :text, :times_per_day, :use_amount)
    end
end
