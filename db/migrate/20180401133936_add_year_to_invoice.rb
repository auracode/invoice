class AddYearToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :year, :integer
  end
end
