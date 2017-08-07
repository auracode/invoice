class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.date :invoice_date
      t.string :billing_name
      t.text :billing_address
      t.string :billing_state
      t.integer :billing_state_code
      t.string :billing_gstid
      t.text :description
      t.integer :quantity
      t.float :rate
      t.string :purchase_order_no

      t.timestamps
    end
  end
end
