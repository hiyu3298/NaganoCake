class Admin::OrdersController < ApplicationController
  def update
    order = Order.find(params[:id])
    #注文ステータスが"入金確認"になったら製作ステータスを"製作待ち"
    if params[:order][:status] == "b"
      order.order_detail.each do |order_detail|
        order_detail.production_status = "b"
        order_detail.update(production_status: order_detail.production_status)
      end
    end
    order.update(order_params)
    redirect_to admin_order_path(order)
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
    #商品合計
    @total = 0
    @order_detail.each do |order_detail|
      tol = order_detail.item.price * order_detail.amount
      @total += tol
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
