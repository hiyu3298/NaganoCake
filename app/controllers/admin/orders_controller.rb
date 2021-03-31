class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

	def index
    @orders = Order.all
	end

	def show
		@order = Order.find(params[:id])
		@order_detail = @order.order_details
	end
end
