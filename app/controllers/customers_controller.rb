class CustomersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update]
  before_action :set_prefixes, only: [:new, :edit]

  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result.page(params[:page])
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = generate_pdf
        pdf.print
        send_data pdf.render, filename: "#{@customer.id}-#{@customer.name}.pdf", type: 'application/pdf', disposition: "inline"
      end
    end
  end

  def new
    @q = Customer.ransack(params[:q])
  	@customer = Customer.new
  end

  def edit
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
  end

  private
  	def customer_params
  		params.require(:customer).permit(:prefix_id, :name, :surname, :sex,
  			:birthdate, :id_card_no, :passport_no, :nationality,
        :occupation,
  			:address, :sub_district, :district, :province, :postal_code,
        :email,
  			:home_phone_no, :tel_no)
  	end

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def set_prefixes
      @prefixes = Prefix.all
    end

    def generate_pdf
      Prawn::Document.new(page_size: "A7", page_layout: :landscape) do |doc|
        doc.font("#{Rails.public_path}/fonts/THSarabun.ttf") do
          doc.text "บัตรประจำตัวคลินิค"
          doc.text "คุณ #{@customer.name} #{@customer.surname}"
          doc.text "#{@customer.id_card_no}"
        end
      end
    end
end
