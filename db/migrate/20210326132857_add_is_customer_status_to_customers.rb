class AddIsCustomerStatusToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :is_customer_status, :boolean, default: false, null: false
  end
end
