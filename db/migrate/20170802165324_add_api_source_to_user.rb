class AddApiSourceToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :api_source, :string
  end
end
