class Invoice < ApplicationRecord
	def total
		@invoice = Invoice.find(self.id)
		(@invoice.quantity)*(@invoice.rate)
	end

	def cgst
		@invoice = Invoice.find(self.id)
		(@invoice.total)*0.14
	end

	def sgst
		@invoice = Invoice.find(self.id)
		(@invoice.total)*0.14
	end

	def gst
		@invoice = Invoice.find(self.id)
		(@invoice.total)*0.28
	end

	def grand_total
		@invoice = Invoice.find(self.id)
		(@invoice.total) + (@invoice.gst)
	end

end
