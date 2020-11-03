class SearchesController < ApplicationController
	before_action :authenticate_user!
	def search
		if params[:word]
			@word = params[:word]
			all_lesson = Lesson.search(@word).only_active
		elsif params[:category_name]
			@category = params[:category_name].to_i
			all_lesson = Lesson.search(@category).only_active
		end
			@lessons = all_lesson.page(params[:page]).reverse_order
			@lessons_count = all_lesson.count
	end


end
