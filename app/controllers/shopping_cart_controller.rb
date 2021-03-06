class ShoppingCartController < ApplicationController
  before_action :set_item, only: [:add_to_cart, :delete_from_cart]

  def add_to_cart
    @item.possible_buyer_id = current_user.id
    if @item.save
      @item.update_columns(status: 1)
      flash[:success] = 'Item added to cart'
      redirect_to my_cart_path
    else
      flash[:error] = @item.errors.messages.values.join(', ')
      redirect_to item_path(@item)
    end
  end

  def delete_from_cart
    @item.update_columns(possible_buyer_id: nil, status: 0)
    flash[:success] = 'Item deleted from cart'
    redirect_to my_cart_path
  end

  def show
    @items = current_user.expected_items
  end

  def check_out
    @order = Order.new
  end

  def create_order
    @order = Order.new(order_params)
    if @order.save
      flash[:success] = 'Order created'
      redirect_to my_orders_path
    else
      render :check_out
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :city, :state ,:country, :zip_code)
      .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
   end
end