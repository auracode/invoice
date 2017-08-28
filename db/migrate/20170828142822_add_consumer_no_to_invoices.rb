class AddConsumerNoToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :consumer_no, :string
  end
end
