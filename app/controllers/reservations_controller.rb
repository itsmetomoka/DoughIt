class ReservationsController < ApplicationController

	def create
		unless current_user.reservations.exists?(lesson_id: params[:lesson_id])
			@reservation = current_user.reservations.new(reservation_params)
			@reservation.save
			redirect_to lesson_reservations_path
		else
			@lesson = Lesson.find(params[:lesson_id])
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
