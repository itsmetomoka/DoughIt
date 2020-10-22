class LessonsController < ApplicationController
  def top
  end

  def about
  end

  def new
    @lesson = Lesson.new
  end

  def create
    lesson = Lesson.new(lesson_params)
    lesson.user_id = current_user.id
    if lesson.save
      redirect_to lessons_complete_path
    else
      render :new
    end
  end

  def index
  end

  def show
  end



  def complete
    
  end

  private
  def lesson_params
    params.require(:lesson).permit(:user_id, :name, :event_date, :tuition, :content, :address, :latitude, :longitude, :deadline, :max_attendees, :category_name, :lesson_image)
  end
end
