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

  def index_by_artist
    @artists = User.artists
  end

  def choose_artist
    @artist = User.find_by_username(params[:username])
    return @items = @artist.items if @artist
    @items = []
  end

  def edit_item
    @item = Item.find(params[:id])
  end

  def update_item
    @item = Item.find(params[:id])
    if @item.update(object_params)
      flash[:success] = "Item updated";
      redirect_to item_path(@item)
    else
      flash[:error] = "Something went wrong"
      render :edit_item
    end
  end

  def items_search
    q = "%#{params[:q]}%"
    @found_items = Item.where("name ILIKE ? OR description ILIKE ?", q, q)
  end

  private

  def object_params
    params.require(:item).permit(:name, :description, :image_url,
                                 :category, :price)
      .merge(user_id: current_user.id)
  end
end
