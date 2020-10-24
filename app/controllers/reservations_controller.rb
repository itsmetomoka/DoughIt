class ReservationsController < ApplicationController

	def create
		reservation = current_user.reservations.new(reservation_params)
		reservation.save
		redirect_to lesson_reservations_path
	end

	def index
		@reservations = current_user.reservations
	end



	private
	def reservation_params
		params.permit(:lesson_id, :user_id)
	end
end
