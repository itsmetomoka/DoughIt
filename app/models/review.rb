class Review < ApplicationRecord
	belongs_to :user
	has_many :notifications, dependent: :destroy
	validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5
  }, presence: true

  validates :review, presence: true, length: {in: 2..100}

  def create_review_notification_by(current_user)
    notification = current_user.active_notifications.new(
      visited_id: user_id,
      action: 'review'
    )
    notification.save if notification.valid?
  end
end
