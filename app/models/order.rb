class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum payment_method: { credit: 0, bunk: 1 }
  enum order_status: { a: 0, b: 1, c: 2, d: 3, e: 4 }
end
