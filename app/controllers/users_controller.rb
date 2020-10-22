class UsersController < ApplicationController

	def show
		@user= User.find(params[:id])
	end

	def edit
		@user = current_user
	end

	def update
		user = current_user
		user.update(user_params)
		redirect_to user_path(current_user.id)
	end

	def check
	end

	def withdrawal
		current_user.destroy
		current_user.update(is_active: false)
		redirect_to root_path
  	end


	private
	def user_params
		params.require(:user).permit(:name, :email, :introduction, :profile_image)
	end
end
