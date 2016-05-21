class CustomersController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
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
  			:birthdate, :id_card_no, :passport_no, :nationality,
        :occupation,
  			:address, :sub_district, :district, :province, :postal_code,
        :email,
  			:home_phone_no, :tel_no)
  	end

    def get_all_prefixes
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
