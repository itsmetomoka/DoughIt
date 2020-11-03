class FavoritesController < ApplicationController
    before_action :authenticate_user!
	def create
	  @lesson = Lesson.find(params[:lesson_id])
    favorite = current_user.favorites.new(lesson_id: @lesson.id)
    favorite.save
    @lesson.create_fav_notification_by(current_user)

	end

	def destroy
	@lesson = Lesson.find(params[:lesson_id])
    favorite = current_user.favorites.find_by(lesson_id: @lesson.id)
    favorite.destroy

    end

    def index
        @lessons = Lesson.where(user_id: current_user.id)
    end


end
