class StoreUnitsController < ApplicationController
  
  before_action :authenticate_user!  
  before_action :set_store_unit, only: [:show, :edit, :update, :destroy]

  # GET /store_units
  # GET /store_units.json
  def index
    @q = StoreUnit.ransack params[:q]
    @store_units = @q.result.page params[:page]
  end

  # GET /store_units/1
  # GET /store_units/1.json
  def show
  end

  # GET /store_units/new
  def new
    @store_unit = StoreUnit.new
  end

  # GET /store_units/1/edit
  def edit
  end

  # POST /store_units
  # POST /store_units.json
  def create
    @store_unit = StoreUnit.new(store_unit_params)

    respond_to do |format|
      if @store_unit.save
        format.html { redirect_to @store_unit, notice: 'Store unit was successfully created.' }
        format.json { render :show, status: :created, location: @store_unit }
      else
        format.html { render :new }
        format.json { render json: @store_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /store_units/1
  # PATCH/PUT /store_units/1.json
  def update
    respond_to do |format|
      if @store_unit.update(store_unit_params)
        format.html { redirect_to @store_unit, notice: 'Store unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @store_unit }
      else
        format.html { render :edit }
        format.json { render json: @store_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_units/1
  # DELETE /store_units/1.json
  def destroy
    @store_unit.destroy
    respond_to do |format|
      format.html { redirect_to store_units_url, notice: 'Store unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_unit
      @store_unit = StoreUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_unit_params
      params.require(:store_unit).permit(:title)
    end
end
