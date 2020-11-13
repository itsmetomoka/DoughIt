class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(params[:user_id])
    @review = current_user.reviews.new(review_params)
    @review.reviewer_id = current_user.id
    @review.user_id = @user.id
    if @review.save
      @review.create_review_notification_by(current_user)
      redirect_to user_reviews_path
    else
      all_lessons = current_user.lessons.only_active
      @lessons = all_lessons.page(params[:page]).reverse_order
      flash[:validate_review] = "空欄の箇所があるか、レビューが100文字以上です"
      render 'users/show'
    end
  end

  def index
    @user = User.find(params[:user_id])
    @reviews = @user.reviews
  end

  private

  def review_params
    params.require(:review).permit(:review, :rate)
  end
end
