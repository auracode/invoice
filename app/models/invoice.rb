class Invoice < ApplicationRecord
	after_create_commit :set_month
	validates :invoice_number, uniqueness: true

	def self.to_csv(options = {})
		desired_columns = ["Invoice no", "Invoice Date", "Party Name","GST Number", "SGST", "CGST", "GST", "Grand Total"]
		CSV.generate(options) do | csv |
			csv << desired_columns
			all.each do |m|
				csv << ["#{m.invoice_number}", "#{m.invoice_date.strftime("%d-%m-%y")}", "#{m.billing_name}","#{m.billing_gstid}", "#{m.sgst}", "#{m.cgst}","#{m.gst}","#{m.grand_total}"]
				
			end

		end
		
	end

	def total
		@invoice = Invoice.find(self.id)
		((@invoice.quantity)*(@invoice.rate)).round(2)
	end

	def cgst
		@invoice = Invoice.find(self.id)
		((@invoice.total)*0.14).round(2)
	end

	def sgst
		@invoice = Invoice.find(self.id)
		((@invoice.total)*0.14).round(2)
	end

	def gst
		@invoice = Invoice.find(self.id)
		((@invoice.total)*0.28).round(2)
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

end
