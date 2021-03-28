class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items
  has_many :orders
  has_many :ordered_items, through: :orders

  def active_for_authentication?
    super && (self.is_customer_status == false)
  end

  def full_name
    first_name + last_name
  end
end
