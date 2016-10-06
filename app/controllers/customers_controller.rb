class CustomersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_prefixes, only: [:new, :edit]
  before_action :set_ransack_search_param, only: [:index, :show, :new, :edit, :update, :create]

  #bc
  add_breadcrumb bc(:list, Customer), :customers_path

  def index
    @customers = @q.result.eager.page(params[:page])
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
  	@customer.set_cn
  end

  def edit
    add_bc :show, customer_path(@customer)
    add_bc :edit, edit_customer_path(@customer)
  end

  def create
  	@customer = Customer.new(create_params)
  	
  	if @customer.save
      redirect_to customer_url(@customer), notice: t("successfully_created")
    else
      set_prefixes
      render 'new'
    end
  end

  def update
    if @customer.update(update_params)
      redirect_to @customer, notice: t("successfully_updated")
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
  	def create_params
      params.require(:customer).permit(:prefix_id, :name, :surname, :sex,
        :cn,
        :birthdate, :id_card_no, :passport_no, :nationality,
        :occupation,
        :address, :street, :sub_district, :district, :province, :postal_code,
        :email,
        :home_phone_no, :tel_no)
  	end

    def update_params
      params.require(:customer).permit(:prefix_id, :name, :surname, :sex,
        :birthdate, :id_card_no, :passport_no, :nationality,
        :occupation,
        :address, :street, :sub_district, :district, :province, :postal_code,
        :email,
        :home_phone_no, :tel_no)
    end

    def set_ransack_search_param
      @q = Customer.ransack(params[:q])
      @q.sorts = "id asc" if @q.sorts.empty?
    end

    def set_customer
      @customer = Customer.eager.find(params[:id])
    end

    def set_prefixes
      @prefixes = Prefix.all
    end

    def add_bc(key, path)
      add_breadcrumb bc(key, Customer), path
    end
end
