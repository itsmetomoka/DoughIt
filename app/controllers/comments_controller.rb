class CommentsController < ApplicationController

	def create
		@lesson = Lesson.find(params[:lesson_id])
		comment = current_user.comments.new(comment_params)
		comment.lesson_id = @lesson.id
		comment.save
	end

	def destroy
	end

	private
	def comment_params
		params.require(:comment).permit(:comment)
	end
end
