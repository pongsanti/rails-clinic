class DiagsController < ApplicationController
  
  before_action :authenticate_user!  
  before_action :set_diag, only: [:show, :edit, :update, :destroy]

  # GET /diags
  # GET /diags.json
  def index
    @q = Diag.ransack params[:q]
    @diags = @q.result.page params[:page]
  end

  # GET /diags/1
  # GET /diags/1.json
  def show
  end

  # GET /diags/new
  def new
    @diag = Diag.new
  end

  # GET /diags/1/edit
  def edit
  end

  # POST /diags
  # POST /diags.json
  def create
    @diag = Diag.new(diag_params)

    respond_to do |format|
      if @diag.save
        format.html { redirect_to @diag, notice: 'Diag was successfully created.' }
        format.json { render :show, status: :created, location: @diag }
      else
        format.html { render :new }
        format.json { render json: @diag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diags/1
  # PATCH/PUT /diags/1.json
  def update
    respond_to do |format|
      if @diag.update(diag_params)
        format.html { redirect_to @diag, notice: 'Diag was successfully updated.' }
        format.json { render :show, status: :ok, location: @diag }
      else
        format.html { render :edit }
        format.json { render json: @diag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diags/1
  # DELETE /diags/1.json
  def destroy
    @diag.destroy
    respond_to do |format|
      format.html { redirect_to diags_url, notice: 'Diag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diag
      @diag = Diag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diag_params
      params.require(:diag).permit(:name, :description)
    end
end
