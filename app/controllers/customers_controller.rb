class CustomersController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
  	@customer = Customer.new
    get_all_prefixes
  end

  def edit
    @customer = Customer.find(params[:id])
    get_all_prefixes
  end

  def create
  	@customer = Customer.new(customer_params)
    @customer.cn = '001'
  	
  	if @customer.save
      redirect_to customer_url(@customer)
    else
      get_all_prefixes
      render 'new'
    end
  end

  def update
    @customer = Customer.find(params[:id])
 
    if @customer.update(customer_params)
      redirect_to @customer
    else
      get_all_prefixes
      render 'edit'
    end    
  end

  def destroy
  end

  private
  	def customer_params
  		params.require(:customer).permit(:prefix_id, :name, :surname, :sex,
  			:birthdate, :id_card_no, :passport_no, :occupation,
  			:address, :sub_district, :district, :province, :postal_code,
  			:home_phone_no, :tel_no)
  	end

    def get_all_prefixes
      @prefixes = Prefix.all
    end
end
