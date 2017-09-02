class AddTypeToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :type, :string
  end
end
