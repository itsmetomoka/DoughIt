class ReviewsController < ApplicationController
	def create
		@user = User.find(params[:user_id])
		review = current_user.reviews.new(review_params)
		review.reviewer_id = current_user.id
		review.user_id = @user.id
		review.save
		redirect_to user_reviews_path
	end

	def index
		user = User.find(params[:user_id])
		@reviews = user.reviews
	end

	private
	def review_params
		params.require(:review).permit(:review,:rate)
	end



end
