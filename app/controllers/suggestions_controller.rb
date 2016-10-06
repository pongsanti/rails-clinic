class SuggestionsController < ApplicationController

  before_action :authenticate_user!

  def provinces
    @provinces = Customer.uniq.where.not(province: "").pluck(:province)
    render json: @provinces, root: false
  end

end