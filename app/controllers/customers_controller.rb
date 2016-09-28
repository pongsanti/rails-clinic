class CustomersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_prefixes, only: [:new, :edit]
  before_action :set_ransack_search_param, only: [:index, :show, :new, :edit, :update, :create]

  #bc
  add_breadcrumb I18n.t "bc.home", :root_path
  add_breadcrumb bc(:list, Customer), :customers_path

  def index
    @customers = @q.result.page(params[:page])
  end

  def provinces
    @provinces = Customer.uniq.where.not(province: "").pluck(:province)
    render json: @provinces, root: false
  end

  def show
    add_bc :show, customer_path(@customer)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "customer_#{@customer.id}",
          page_height: "46mm", page_width: "80mm"
      end
    end
  end

  def new
    add_bc :new, new_customer_path
  	@customer = Customer.new
  end

  def edit
    add_bc :show, customer_path(@customer)
    add_bc :edit, edit_customer_path(@customer)
  end

  def create
  	@customer = Customer.new(customer_params)
    @customer.cn = '001'
  	
  	if @customer.save
      redirect_to customer_url(@customer)
    else
      set_prefixes
      render 'new'
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer
    else
      set_prefixes
      render 'edit'
    end    
  end

  def destroy
    @customer.destroy
    redirect_to customers_url, notice: t("successfully_destroyed")
  end

  private
  	def customer_params
  		params.require(:customer).permit(:prefix_id, :name, :surname, :sex,
  			:birthdate, :id_card_no, :passport_no, :nationality,
        :occupation,
  			:address, :street, :sub_district, :district, :province, :postal_code,
        :email,
  			:home_phone_no, :tel_no)
  	end

    def set_ransack_search_param
      @q = Customer.ransack(params[:q])
    end

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def set_prefixes
      @prefixes = Prefix.all
    end

    def add_bc(key, path)
      add_breadcrumb bc(key, Customer), path
    end

end
