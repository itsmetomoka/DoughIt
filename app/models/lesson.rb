class Lesson < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :reservations
	attachment :lesson_image

	enum category_name: [:洋食, :和食, :パン, :ケーキ]
end
