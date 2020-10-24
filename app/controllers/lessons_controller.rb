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
    @lesson = current_user.lessons.new(lesson_params)
    if !@lesson.image.present?
      @lesson.image.retrieve_from_cache! @lesson.image_cache
    end
    @lesson.image_cache = @lesson.image.cache_name
  end


  def create
    @lesson = current_user.lessons.new(lesson_params)
    @lesson.image.retrieve_from_cache! @lesson.image_cache
    @lesson.save
    redirect_to lessons_complete_path
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
    params.require(:lesson).permit(:user_id, :name, :event_date, :tuition, :content, :address, :latitude, :longitude, :deadline, :max_attendees, :category_name, :image, :image_cache, :is_active)
  end
end
