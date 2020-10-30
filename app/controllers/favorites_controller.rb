class FavoritesController < ApplicationController
	def create
	@lesson = Lesson.find(params[:lesson_id])
    favorite = current_user.favorites.new(lesson_id: @lesson.id)
    favorite.save

	end
	def destroy
	@lesson = Lesson.find(params[:lesson_id])
    favorite = current_user.favorites.find_by(lesson_id: @lesson.id)
    favorite.destroy

  end


end
