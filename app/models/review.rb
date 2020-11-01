class Review < ApplicationRecord
	belongs_to :user
	validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5
  }, presence: true

  validates :review, presence: true, length: {in: 2..100}
end
