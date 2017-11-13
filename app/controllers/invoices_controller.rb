class InvoicesController < ApplicationController
  

  def index
  	@customers = User.customers
  end

  def new
    @invoice = Invoice.new
    @invoice.invoice_number = params[:invoice_number]
    @invoice.billing_name = params[:billing_name]	
    @invoice.billing_address = params[:billing_address]
    @invoice.billing_gstid = params[:billing_gstid]
    @invoice.quantity = params[:quantity]
    @invoice.rate = params[:rate]
    @invoice.consumer_no = params[:consumer_no]
      
  end

  def create
		@invoice = Invoice.new(invoice_params)
		@invoice.save

    print @invoice.billing_type

    if @invoice.billing_type == "true"
      print "yeah! its an invoice"
    redirect_to @invoice
    elsif @invoice.billing_type == "false"
      print "yeah! its a challan"
      redirect_to challan_invoice_path(@invoice)
		end
  end

  def challan
    @invoice = Invoice.find(params[:id])
   respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@invoice.billing_name}" 

        #template:  'invoices/#{format}/challan.pdf.erb'
          # Excluding ".pdf" extension.
      end
    end
    
  end

  def show
	@invoice = Invoice.find(params[:id])
  respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@invoice.billing_name}"   # Excluding ".pdf" extension.
      end
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(invoice_params) && @invoice.billing_type == "true"
      flash[:success] = "Invoice updated!"
    redirect_to invoice_path(@invoice)
  elsif @invoice.update_attributes(invoice_params) && @invoice.billing_type == "false"
      flash[:success] = "Challan updated!"
      redirect_to challan_invoice_path(@invoice)
    else
      render 'edit'
    end
  end

  def invoice_list
    @customers = User.customers
    @invoices = Invoice.all
    respond_to do | format|
      format.html
      format.csv {send_data @invoices.to_csv }
      format.xls {send_data @invoices.to_csv(col_sep: "\t") }
    end
  end
 
 private

    def invoice_params
      params.require(:invoice).permit(:invoice_number, :invoice_date, :billing_name, :billing_address, :billing_state_code, :billing_gstid, :description , :quantity, :rate, :purchase_order_no, :consumer_no, :billing_type, :gst_rate, :hsn_code)
    end

  
end
