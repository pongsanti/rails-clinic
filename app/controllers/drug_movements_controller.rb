class DrugMovementsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_drugs, only: [:new]
  before_action :set_holder, only: [:new, :create, :destroy]
  before_action :set_list_holder, only: [:new, :create, :destroy]
  before_action :set_drug_movement, only: [:destroy]
  #before_action :set_ransack_search_param, only: [:index]
  before_action :set_drug_in, only: [:index]

  def index
    ransack_params = {for_drug_in: @drug_in.id}
    ransack_params = ransack_params.merge(params[:q]) if params[:q]

    @q = DrugMovement.ransack(ransack_params)
    @drug_movements = @q.result.page(params[:page])

    @drug = @drug_in.drug
  end

  def show
  end

  def new
    @drug_movement = DrugMovement.new(drug_movement_params)
  end

  def edit
  end

  def create
    @drug_movement = DrugMovement.new(drug_movement_params)

    unless @drug_movement.valid?
      set_drugs
      render :new and return
    end

    drug_in = @drug_movement.drug_in
    drug_in.create_movement_for_drug_out(@drug_movement)

    drug_in.transaction do
      drug_in.save
      drug_in.drug.recal_balance
    end

    set_exam
  end

  def update
  end

  def destroy
    drug_in = @drug_movement.drug_in
    @drug_movement.transaction do
      # drug_in balance
      drug_in.balance = @drug_movement.prev_bal  
      drug_in.save
      # drug balance
      drug = Drug.find(drug_in.drug.id)
      drug.recal_balance
      # destroy movement
      @drug_movement.destroy
    end
    set_exam
  end

  private
    #def set_ransack_search_param
    #  @q = DrugMovement.ransack(params[:q])
    #end

    def set_drug_in
      @drug_in = DrugIn.find(params[:drug_in_id])
    end

    def drug_movement_params
      params.require(:drug_movement).permit(:note, :drug_in_id, :exam_id, :amount)
    end

    def set_drug_movement
      @drug_movement = DrugMovement.find(params[:id])
    end

    def set_drugs
      @drugs = Drug.drug_ins_exist
    end

    def set_holder
      @holder = params[:holder]
    end

    def set_list_holder
      @list_holder = params[:list_holder]
    end

    def set_exam
      @exam = @drug_movement.exam
    end

end