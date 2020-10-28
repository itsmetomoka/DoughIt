class SearchesController < ApplicationController

	def search
		if params[:word]
			@word = params[:word]
			all_lesson = Lesson.search(@word)
		else
			@category = params[:category_name].to_i
			all_lesson = Lesson.search(@category)
		end
			@lessons = all_lesson.page(params[:page]).reverse_order
			@lessons_count = all_lesson.count
	end
end
