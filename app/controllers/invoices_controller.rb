class InvoicesController < ApplicationController
  def index
  	@customers = User.customers
  end

  def new
    @invoice = Invoice.new
    @invoice.billing_name = params[:billing_name]	
    @invoice.billing_address = params[:billing_address]
    @invoice.billing_gstid = params[:billing_gstid]
    @invoice.quantity = params[:quantity]
    @invoice.rate = params[:rate]
      
  end

  def create
		@invoice = Invoice.new(invoice_params)
		@invoice.save
		redirect_to @invoice
  end

  def show
	@invoice = Invoice.find(params[:id])
  respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Invoice#{@invoice.billing_name}"   # Excluding ".pdf" extension.
      end
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(invoice_params)
      flash[:success] = "Invoice updated!"
    redirect_to invoice_path(@invoice)
    else
      render 'edit'
    end
  end
 
 private

    def invoice_params
      params.require(:invoice).permit(:invoice_number, :invoice_date, :billing_name, :billing_address, :billing_state_code, :billing_gstid, :description , :quantity, :rate, :purchase_order_no)
    end

end