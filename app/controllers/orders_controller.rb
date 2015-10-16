class OrdersController < ApplicationController
	before_action :set_order, only: [:show]
  def index
    @orders = current_user.orders
    @total = @orders.map {|order| order.cost}.sum
  end

  def show; end

  private

  def set_order
  	@order = Order.find(params[:id])
  end
end
