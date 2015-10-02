class ProductsController < ApplicationController

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(object_params)
		if @product.save
			flash[:success] = 'Product created'
			redirect_to root_path
		else
			render :new
		end
	end

	private 

	def object_params
		params.require(:product).permit(:name, :description, :image_url, :quantity)
			.merge(user_id: current_user.id)
	end
end
