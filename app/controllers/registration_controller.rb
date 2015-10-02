class RegistrationController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(object_params)
		if @user.save
			flash[:success] = "You have been registered"
			login_with_new_user
			redirect_to root_path
		else
			render :new
		end
	end

	private

	def object_params
		params.require(:user).permit(:email, :name, :last_name, :username,
																 :password, :password_confirmation)
	end

	def login_with_new_user
		session[:user_id] = @user.id
		session[:role] = @user.main_role
	end
end
