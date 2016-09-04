class DiagsController < ApplicationController
  
  before_action :authenticate_user!  
  before_action :set_diag, only: [:show, :edit, :update, :destroy]
  before_action :set_ransack_search_param, only: [:index, :show, :new, :edit, :create, :update]

  def index
    @diags = @q.result.page(params[:page])
  end

  def show
  end

  def new
    @diag = Diag.new
  end

  def edit
  end

  def create
    @diag = Diag.new(diag_params)

    if @diag.save
      redirect_to @diag, notice: t('successfully_created')
    else
      render :new
    end
  end

  def update
    if @diag.update(diag_params)
      redirect_to @diag, notice: t('successfully_updated')  
    else
      render :edit
    end
  end

  def destroy
    @diag.destroy
    redirect_to diags_url, notice: t('successfully_destroyed')
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

    def set_ransack_search_param
      param_q = params[:q].blank? ? {"s"=>"id asc"} : params[:q]
      @q = Diag.ransack(param_q)
    end
end
