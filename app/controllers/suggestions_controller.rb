class SuggestionsController < ApplicationController

  before_action :authenticate_user!

  def provinces
    @provinces = Customer.uniq.where.not(province: "").pluck(:province)
    render json: @provinces, root: false
  end

  def districts
    @districts = Customer.uniq.where.not(district: "").pluck(:district)
    render json: @districts, root: false
  end

end