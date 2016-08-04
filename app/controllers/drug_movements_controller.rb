class DrugMovementsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_drugs, only: [:new]
  before_action :set_holder, only: [:new, :create]

  def index
  end

  def show
  end

  def new
    @drug_movement_amount = DrugMovementAmount.new
    @drug_movement = DrugMovement.new
    @exam_id = params[:exam_id]
  end

  def edit
  end

  def create
    @drug_movement_amount = DrugMovementAmount.new(amount: params[:amount])
    @drug_movement = DrugMovement.new(drug_movement_params)

    unless @drug_movement_amount.valid?
      set_drugs
      @exam_id = params[:exam_id]
      render :new and return
    end

    @drug_movement.exam = Exam.find params[:drug_movement][:exam_id]
    @drug_movement.drug_in = DrugIn.find params[:drug_movement][:drug_in_id]
    @drug_movement.note = params[:drug_movement][:note]
    prev_bal = @drug_movement.drug_in.drug_movements.last.balance
    balance = prev_bal - BigDecimal.new(params[:amount])

    @drug_movement.prev_bal = prev_bal
    @drug_movement.balance = balance

    @drug_movement.drug_in.balance = balance


    @drug_movement.transaction do 
      @drug_movement.save
      @drug_movement.drug_in.save
    end
    
  end

  def update
  end

  def destroy
  end

  private
    def drug_movement_params
      params.require(:drug_movement).permit(:note, :exam_id, :drug_in_id)
    end

    def set_drugs
      @drugs = Drug.drug_ins_exist
    end

    def set_holder
      @holder = params[:holder]
    end

end