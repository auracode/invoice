class AddHsncodeToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :hsn_code, :integer
  end
end
