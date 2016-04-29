class CustomersController < ApplicationController
  
  before_action :authenticate_user!

  def new
  	@customer = Customer.new
    @prefixes = prefix_all
  end

  def create
    #render plain: customer_params.inspect
  	@customer = Customer.new(customer_params)
  	
  	if @customer.save
      render plain: customer_params.inspect
    else
      @prefixes = prefix_all
      render 'new'
    end
  end

  private
  	def customer_params
  		params.require(:customer).permit(:prefix_id, :name, :surname, :sex,
  			:id_card, :passport_no, :birth_date,
  			:address, :sub_district, :district, :province, :postal_code,
  			:occupation, :tel_no)
  	end

    def prefix_all
      Prefix.all
    end
end
