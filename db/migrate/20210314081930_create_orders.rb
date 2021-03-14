class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.string :shipping_postal_code
      t.string  :shipping_address
      t.string  :delivery_name
      t.integer :shipping_cost
      t.integer  :shipping_amount
      t.integer :payment_method,default: 0,null: false
      t.integer :order_status,default: 0,null: false
      t.timestamps
    end
  end
end
