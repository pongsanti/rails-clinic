class DrugMovementsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_drugs, only: [:new]
  before_action :set_holder, only: [:new, :create, :destroy]
  before_action :set_list_holder, only: [:new, :create, :destroy]
  before_action :set_drug_movement, only: [:destroy]

  def index
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

    prev_bal = @drug_movement.drug_in.drug_movements.last.balance
    balance = prev_bal - BigDecimal.new(@drug_movement.amount)

    @drug_movement.prev_bal = prev_bal
    @drug_movement.balance = balance

    @drug_movement.drug_in.balance = balance

    @drug_movement.transaction do 
      @drug_movement.save
      @drug_movement.drug_in.save
      @drug_movement.drug_in.drug.recal_balance
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