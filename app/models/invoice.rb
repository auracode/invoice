class Invoice < ApplicationRecord
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

end
