class DrugMovementsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    render plain: params.inspect
  end

  def update
  end

  def destroy
  end

end