class Lesson < ApplicationRecord
	attachment :image
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :reservations
end
