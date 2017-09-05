class AddBillingTypeToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :billing_type, :string
  end
end
