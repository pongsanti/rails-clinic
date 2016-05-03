class ExamsController < ApplicationController
  
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
    @exam = Exam.new
    @customer = Customer.find(params[:customer_id])
    @exam.customer = @customer
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
    def exams_params
      params.require(:exam).permit()
    end
end
