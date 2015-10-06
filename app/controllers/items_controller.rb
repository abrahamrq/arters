class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(object_params)
    if @item.save
      flash[:success] = 'Item created'
      redirect_to my_items_path
    else
      render :new
    end
  end

  def my_items
    @items = current_user.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def index_by_category
    @categories = Item.categories.keys
  end

  def choose_category
    @items = Item.send(params[:category])
  end

  private

  def object_params
    params.require(:item).permit(:name, :description, :image_url, :quantity,
                                 :category)
      .merge(user_id: current_user.id)
  end
end
