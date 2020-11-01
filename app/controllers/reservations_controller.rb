class ReservationsController < ApplicationController

	def create
		@lesson = Lesson.find(params[:lesson_id])
		unless current_user.reservations.exists?(lesson_id: params[:lesson_id])
			@reservation = current_user.reservations.new(reservation_params)
			@reservation.save
			@lesson.create_reservate_notification_by(current_user)
			redirect_to lesson_reservations_path
		else
			@reservations = current_user.reservations
			flash[:validate] = "既にこちらのレッスンは予約しています"
			render :index
		end
	end

	def index
		@reservations = current_user.reservations
	end



	private
	def reservation_params
		params.permit(:lesson_id, :user_id)
	end
end
