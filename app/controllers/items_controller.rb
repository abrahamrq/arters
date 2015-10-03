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

	private 

	def object_params
		params.require(:item).permit(:name, :description, :image_url, :quantity)
			.merge(user_id: current_user.id)
	end
end
