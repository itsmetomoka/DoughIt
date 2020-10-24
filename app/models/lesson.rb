class Lesson < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :reservations, dependent: :destroy
	belongs_to :user
	attr_accessor :image_cache
	mount_uploader :image, ImageUploader

	enum category_name: {洋食: 0, 和食: 1, パン: 2, ケーキ: 3}

	with_options presence: true do
		validates :tuition
		validates :name, length: {maximum:100}
		validates :content, length: {in: 20..200}
		validates :event_date
		validates :deadline


	end



end
