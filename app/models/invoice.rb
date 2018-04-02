class Invoice < ApplicationRecord
	after_create_commit :set_month, :set_year
	validates :invoice_number, uniqueness: true

	def self.to_csv(options = {})
		desired_columns = ["Sr no","Invoice no", "Invoice Date", "Party Name","GST Number","Sub Total", "SGST", "CGST", "GST", "Grand Total"]
		CSV.generate(options) do | csv |
			csv << desired_columns
			all.each do |m|
				csv << ["#{m.id}","#{m.invoice_number}", "#{m.invoice_date.strftime("%d-%m-%y")}", "#{m.billing_name}","#{m.billing_gstid}","#{m.total}", "#{m.sgst}", "#{m.cgst}","#{m.gst}","#{m.grand_total}"]
			end
		end
	end

	def total
		@invoice = Invoice.find(self.id)
		((@invoice.quantity)*(@invoice.rate)).round(2)
	end

	def cgst
		@invoice = Invoice.find(self.id)
		if @invoice.gst_rate.present?
		((@invoice.total)*(@invoice.gst_rate*0.5/100)).round(2)
		else	
		((@invoice.total)*0.14).round(2)
		end
	end

	def sgst
		@invoice = Invoice.find(self.id)
		if @invoice.gst_rate.present?
		((@invoice.total)*(@invoice.gst_rate*0.5/100)).round(2)
		else	
		((@invoice.total)*0.14).round(2)
		end
	end

	def gst
		@invoice = Invoice.find(self.id)
		if @invoice.gst_rate.present?
		((@invoice.total)*(@invoice.gst_rate/100.0)).round(2)
		else	
		((@invoice.total)*0.28).round(2)
		end
		
	end

	def grand_total
		@invoice = Invoice.find(self.id)
		((@invoice.total) + (@invoice.gst)).round(2)
	end

	def set_month
      @invoice = Invoice.find(self.id)
      @invoice.month = @invoice.invoice_date.month
      @invoice.save
      
    end

    def set_year
      @invoice = Invoice.find(self.id)
      @invoice.year = @invoice.invoice_date.year 
      @invoice.save
    end

    def update_year
      @invoice = Invoice.find(self.id)
      @invoice.update_attribute( :year, @invoice.invoice_date.year ) 
      
    end

    def self.invoicesfy1718
    	year =[2017,2018]
    	@invoicesall =  Invoice.all
    	@invoices=@invoicesall.where(:year => year)
    end

    def self.invoicesfy1819
    	year =[2019,2018]
    	@invoicesall =  Invoice.all
    	@invoices=@invoicesall.where(:year => year)
    end
end
