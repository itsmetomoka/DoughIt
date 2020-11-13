class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def create
    @lesson = Lesson.find(params[:lesson_id])
    if current_user.reservations.exists?(lesson_id: params[:lesson_id])
      flash[:validate] = "既にこちらのレッスンは予約しています"
      redirect_to lesson_reservations_path
    else
      @reservation = current_user.reservations.new(reservation_params)
      @reservation.save
      @lesson.create_reservate_notification_by(current_user)
      redirect_to lesson_reservations_path
    end
  end

  def index

    reserved_lessons = current_user.reserved_lessons
    if params[:sort] == 'date'
      all_lessons = reserved_lessons.order(event_date: :DESC)
    else
      all_lessons = reserved_lessons
    end
    @lessons = all_lessons.page(params[:page]).reverse_order
    @lessons_calendar = Lesson.all
  end

  private

  def reservation_params
    params.permit(:lesson_id, :user_id)
  end
end
