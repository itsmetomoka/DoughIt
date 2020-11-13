class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validate :check_the_number_of_reservation

  def check_the_number_of_reservation
    if lesson && lesson.reservations.count >= lesson.max_attendees
      errors.add(:lesson, "は定員数に達しています")
    end
   end
end
