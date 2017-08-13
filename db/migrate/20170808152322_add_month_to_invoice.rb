class AddMonthToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :month, :string
  end
end
