class UsersController < ApplicationController

	def show
		@user= User.find(params[:id])
		all_lessons = current_user.lessons.only_active
		@lessons = all_lessons.page(params[:page]).reverse_order
		if @user.reviews.blank?
			@average = 0
		else
			@average = @user.reviews.average(:rate).round(2)
	end
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		if @user.update(user_params)
			redirect_to user_path(current_user.id)
		else
			@user.errors.full_messsages.each do |message|
				pp message
			end
			render :edit
		end
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
		params.require(:user).permit(:name, :email, :introduction, :image)
	end
end
