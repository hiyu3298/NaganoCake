class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @addresses = Address.all
    @ordered = Order.all
  end

  def check
    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item|
      tal = cart_item.item.price * cart_item.amount
      @total += tal
    end
    if session[:user]["payment_method"] == "credit"
      @payment_method = "クレジット払い"
    elsif session[:user]["payment_method"] == "bank"
      @payment_method = "現金払い"
    end
  end

  def create
    session[:user] = Order.new()

    #支払い方法のセッション情報
    if params[:payment_select] == "0"
      session[:user][:payment_method] = 0
    elsif params[:payment_select] == "1"
      session[:user][:payment_method] = 1
    end

    #配送先登録のセッション情報
    if params[:address_select] == "0"
      session[:user][:shipping_postal_code] = current_customer.postal_code
      session[:user][:shipping_address] = current_customer.address
      session[:user][:delivery_name] = current_customer.full_name
    elsif params[:address_select] == "1"
      session[:user][:shipping_postal_code] =  Address.find(params[:address_id]).postal_code
      session[:user][:shipping_address] = Address.find(params[:address_id]).address
      session[:user][:delivery_name] = Address.find(params[:address_id]).name
    else
      session[:user][:shipping_postal_code] =  params[:postal_code]
      session[:user][:shipping_address] = params[:shipping_address]
      session[:user][:delivery_name] = params[:delivery_name]
    end
    redirect_to orders_check_path

  end

  def thanks
    order = Order.new(session[:user])
    order.shipping_cost = 500
    order.shipping_amount = 1000
    order.order_status = 1
    order.customer_id = current_customer.id
    order.save
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = order.id
      order_detail.item_id = cart_item.item.id
      order_detail.production_status = 0
      order_detail.non_taxed_price = cart_item.item.price
      order_detail.amount = cart_item.amount
      order_detail.save
    end
    cart_items.delete_all
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:delivery_name, :postal_code,:shipping_address,:payment_method)
  end

  def cart_item_any?
    if current_customer.cart_items.empty?
      redirect_to customers_path
    end
  end
end
