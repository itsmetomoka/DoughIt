class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @lesson = Lesson.find(params[:lesson_id])
    @comment = current_user.comments.new(comment_params)
    @comment.lesson_id = @lesson.id
    @comment.save
    @comment.lesson.create_notification_comment!(current_user, @comment.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
