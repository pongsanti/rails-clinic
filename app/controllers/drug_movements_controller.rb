class DrugMovementsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_drug_movement, only: [:show, :destroy]

  before_action :set_drug_in, only: [:index, :new, :create]
  before_action :set_drug_in_from_drug_movement, only: [:show]
  before_action :set_drug_from_drug_in, only: [:index, :show, :new, :create]

  def index
    ransack_params = {for_drug_in: @drug_in.id}
    ransack_params = ransack_params.merge(params[:q]) if params[:q]

    @q = DrugMovement.ransack(ransack_params)
    @q.sorts = "created_at desc" if @q.sorts.empty?
    @drug_movements = @q.result.page(params[:page])
  end

  def show
  end

  def new
    @drug_movement = DrugMovement.new
  end

  def create
    @drug_movement = DrugMovement.new(drug_movement_params)
    @drug_in.create_movement_for_drug_out(@drug_movement)

    if @drug_in.save
      @drug_in.drug.recal_balance
      redirect_to drug_in_drug_movements_url(@drug_in), notice: t("successfully_created")
    else
      render :new
    end
  end

  private
    def set_drug_in
      @drug_in = DrugIn.find(params[:drug_in_id])
    end

    def set_drug_in_from_drug_movement
      @drug_in = @drug_movement.drug_in
    end

    def set_drug_from_drug_in
      @drug = @drug_in.drug
    end

    def drug_movement_params
      params.require(:drug_movement).permit(:note, :amount)
    end

    def set_drug_movement
      @drug_movement = DrugMovement.find(params[:id])
    end

end