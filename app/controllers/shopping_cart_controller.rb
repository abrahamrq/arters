class ShoppingCartController < ApplicationController
  before_action :set_item, only: [:add_to_cart, :delete_from_cart]

  def add_to_cart
    @item.possible_buyer_id = current_user.id
    if @item.save
      @item.chosen!
      flash[:success] = 'Item added to cart'
      redirect_to my_cart_path
    else
      flash[:error] = "The item you selected can't be added to your cart"
      render :show
    end
  end

  def delete_from_cart
    @item.possible_buyer_id = nil
    if @item.save
      @item.in_stock!
      flash[:success] = 'Item deleted from cart'
      redirect_to my_cart_path
    end
  end

  def show
    @items = current_user.expected_items
  end

  def check_out
  end

  private

  def set_item
    @item = Item.find(params[:id])
   end
end
