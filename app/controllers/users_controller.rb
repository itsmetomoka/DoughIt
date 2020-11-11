class UsersController < ApplicationController
	before_action :authenticate_user!
	# before_action :check_guest, only: [:update, :withdrawal]
	def show
		@user= User.find(params[:id])
		all_lessons = @user.lessons.only_active
		@lessons = all_lessons.page(params[:page]).reverse_order
		if @user.reviews.blank?
			@average_review = 0
		else
			@average_review = @user.reviews.average(:rate).round(2)
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
			@user.errors.full_messages.each do |message|
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


  def check_guest
    if current_user.email == 'guest@example.com'
    	@user = current_user
    	flash[:alert] = "ゲストユーザーの方は変更/削除はできません"
      render :edit
    end
  end

end
