class AddCustomerIdToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :customer_id, :integer
    add_column :addresses, :address, :string
    add_column :addresses, :name, :string
    add_column :addresses, :postal_code, :string
  end
end
