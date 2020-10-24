class LessonsController < ApplicationController
  def top
    @lessons = Lesson.all
  end

  def about
  end

  def new
    @lesson = Lesson.new
  end

  def confirm
    @lesson = Lesson.new(lesson_params)
    @lesson.name = params[:lesson][:name]
    @lesson.event_date = params[:lesson][:event_date]
    @lesson.deadline = params[:lesson][:deadline]
    @lesson.max_attendees = params[:lesson][:max_attendees].to_i
    @lesson.category_name = params[:lesson][:category_name]
    @lesson.lesson_image = params[:lesson][:lesson_image]
    @lesson.tuition = params[:lesson][:tuition].to_i
    @lesson.content = params[:lesson][:content]
    @lesson.address = params[:lesson][:address]
  end

  def create
    @lesson = current_user.lessons.new(lesson_params)
    if @lesson.save
      redirect_to lessons_complete_path
    else
      render :new
    end
  end

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      all_lesson = user.lessons
    else
      all_lesson = Lesson.all
    end
    @lessons = all_lesson.page(params[:page]).reverse_order
  end

  def show
    @lesson = Lesson.find(params[:id])
  end



  def complete
    @lesson = Lesson.order(created_at: :desc).limit(1)
  end

  private
  def lesson_params
    params.require(:lesson).permit(:user_id, :name, :event_date, :tuition, :content, :address, :latitude, :longitude, :deadline, :max_attendees, :category_name, :lesson_image, :is_active)
  end
end
