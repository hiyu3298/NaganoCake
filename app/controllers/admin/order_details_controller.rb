class Admin::OrderDetailsController < ApplicationController
  def update
      order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
      order = order_detail.order
      #注文商品の製作ステータスが1つでも“製作中“で注文ステータスを“製作中“に更新
      if params[:order_detail][:production_status] == "c"
        order.update(status: "c")
      end
      
      order_detail.update(production_status: params[:order_detail][:production_status]
      
      #注文商品全ての製作ステータスが“製作完了“で注文ステータスを“発送準備中“に
      status = 0
      
      order = Order.find(params[:id])
      order.order_detail.each do |order_detail|
        if order_detail.production_status != "d"
          status = 1
        end
      end
      if status == 0
        order.update(status: "d")
      end
      redirect_to admin_orders_path
  end
end
