class AddPaymentDetailsToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :payment_status, :string
    add_column :invoices, :payment_type, :string
    add_column :invoices, :payment_collected_by, :string
    add_column :invoices, :paymg, :string
    add_column :invoices, :payment_collected_on, :date
    add_column :invoices, :payment_details, :string
  end
end
