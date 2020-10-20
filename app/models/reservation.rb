class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :lessons
end
