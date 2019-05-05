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
    @d1819start = Date.today.beginning_of_year.next_quarter.last_year
    @d1819stop = Date.today.beginning_of_year.next_quarter
    @invoices = Invoice.where("invoice_date >= ? AND invoice_date <= ?", @d1819start, @d1819stop)
    respond_to do | format|
      format.html
      format.csv {send_data @invoices.to_csv }
      format.xls {send_data @invoices.to_csv(col_sep: "\t") }
    end
  end

  def invoice_list1718
    @customers = User.customers
    @d1718start = Date.today.beginning_of_year.next_quarter.last_year.last_year
    @d1718stop = Date.today.beginning_of_year.next_quarter.last_year
    @invoices = Invoice.where("invoice_date >= ? AND invoice_date <= ?", @d1718start, @d1718stop)
    respond_to do | format|
      format.html
      format.csv {send_data @invoices.to_csv }
      format.xls {send_data @invoices.to_csv(col_sep: "\t") }
    end
  end
 
 def Q1
    @customers = User.customers
    if Date.today.year == 2019
      @d1start = Date.today.beginning_of_year.next_quarter
      @d1stop = Date.today.beginning_of_year.next_quarter.end_of_quarter
    else 
      @d1start = Date.today.beginning_of_year.next_quarter.last_year
      @d1stop = Date.today.beginning_of_year.next_quarter.last_year.end_of_quarter
    end
    @invoices = Invoice.where("invoice_date >= ? AND invoice_date <= ?", @d1start, @d1stop)    
  end

def Q2
    @customers = User.customers
    if 
      @d2start = Date.today.beginning_of_year.next_quarter.next_quarter
      @d2stop = Date.today.beginning_of_year.next_quarter.next_quarter.end_of_quarter
    else
      @d2start = Date.today.beginning_of_year.next_quarter.last_year.next_quarter
      @d2stop = Date.today.beginning_of_year.next_quarter.last_year.next_quarter.end_of_quarter
    end
    @invoices = Invoice.where("invoice_date >= ? AND invoice_date <= ?", @d2start, @d2stop) 
  end
 
def Q3
    @customers = User.customers
    if Date.today.year == 2019
      @d3start = Date.today.beginning_of_year.last_quarter.beginning_of_quarter
      @d3stop = Date.today.beginning_of_year.last_quarter.end_of_quarter
    else
      @d3start = Date.today.beginning_of_year.last_quarter.last_year.beginning_of_quarter
      @d3stop = Date.today.beginning_of_year.last_quarter.end_of_quarter
    end
    
    @invoices = Invoice.where("invoice_date >= ? AND invoice_date <= ?", @d3start, @d3stop)    
end

def Q4
    @customers = User.customers
    @d4start = Date.today.beginning_of_year
    @d4stop = Date.today.beginning_of_year.end_of_quarter
    @invoices = Invoice.where("invoice_date >= ? AND invoice_date <= ?", @d4start, @d4stop)    
end 

def list
    @date_list = (Time.now.beginning_of_month - 1.month)..(Time.now.beginning_of_month - 1.day)
    @invoices = Invoice.where({invoice_date: @date_list})
end
 

 private

    def invoice_params
      params.require(:invoice).permit(:invoice_number, :invoice_date, :billing_name, :billing_address, :billing_state_code, :billing_gstid, :description , :quantity, :rate, :purchase_order_no, :consumer_no, :billing_type, :gst_rate, :hsn_code)
    end

  
end
