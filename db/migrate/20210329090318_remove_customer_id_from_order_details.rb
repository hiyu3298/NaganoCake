class RemoveCustomerIdFromOrderDetails < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_details, :customer_id, :integer
  end
end
