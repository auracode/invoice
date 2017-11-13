class AddGstrateToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :gst_rate, :integer
  end
end
