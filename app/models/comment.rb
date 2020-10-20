class Comment < ApplicationRecord
	belongs_to :user
	belogns_to :lesson
end
