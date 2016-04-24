class CustomersController < ApplicationController
  def new
  	@customer = Customer.new()
    @prefixes = Prefix.all()
  end

  def create
  	@customer = Customer.new(customer_params)
  	
  	@customer.save
  	redirect_to @customer
  end

  private
  	def customer_params
  		params.require(:customer).permit(:prefix, :name, :surname, :sex,
  			:id_card, :passport_no, :birth_date,
  			:address, :sub_district, :district, :province, :postal_code,
  			:occupation, :tel_no)
  	end
end
