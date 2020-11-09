class Lesson < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :reservations, dependent: :destroy
	belongs_to :user
  has_many :notifications, dependent: :destroy

  
	attr_accessor :image_cache
	mount_uploader :image, ImageUploader

	enum category_name: {洋食: 0, 和食: 1, パン: 2, ケーキ: 3}

  scope :only_active, -> { where(is_active: 1) }
  scope :not_active, -> { where(is_active: 0) }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?


	with_options presence: true do
		validates :tuition
		validates :name, length: {in: 5..50}
		validates :content, length: {in: 20..200}
		validates :event_date
		validates :deadline
    validates :category_name
    validates :max_attendees
    validates :address, length: {in: 5..100}
	end

  validate :deadline_should_be_before_event_date
  validate :event_date_should_be_after_today
  validate :deadline_shoud_be_after_today


	# 募集締め切りが開催日よりも前の日付か
  def deadline_should_be_before_event_date
    if deadline.present? && event_date.present? && self.event_date < self.deadline
      errors.add(:deadline, "の日付を正しく記入してください。")
    end
  end

# 開催日が当日以降であるか
  def event_date_should_be_after_today
    if event_date.present? && self.event_date < DateTime.now
  	   errors.add(:event_date, "は今日以降に設定してください")
    end
  end

# 募集締め切り日が当日以降であるか
  def deadline_shoud_be_after_today
    if deadline.present? && self.deadline < DateTime.now
  	 errors.add(:deadline, "は今日以降に設定してください")
    end
  end

# カレンダー
  def start_time
  	self.event_date
  end

  # 検索機能
  def self.search(word)
  	@lesson = Lesson.where("name LIKE?","%#{word}%")
  end

  def self.search(category)
  	@lesson = Lesson.where("category_name LIKE?","#{category}")
  end

  # いいね機能
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


  # ====通知機能======

# いいね
  def create_fav_notification_by(current_user)
    notification = current_user.active_notifications.new(
      lesson_id: id,
      visited_id: user_id,
      action: "favorite"
    )
    if notification.visitor_id == notification.visited_id
      notification.is_checked = true
    end
    notification.save if notification.valid?
  end

# 予約
  def create_reservate_notification_by(current_user)
    notification = current_user.active_notifications.new(
      lesson_id: id,
      visited_id: user_id,
      action: "reservation"
    )
    notification.save if notification.valid?
  end

# コメント
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(lesson_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
        save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      lesson_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分のレッスンに対するコメントの場合は、通知を送らない
    if notification.visitor_id == notification.visited_id
      notification.is_checked = true
    end
    notification.save if notification.valid?
  end

  def self.categorize(selection)
    case selection
    when 'early'
      return all.order(event_date: :DESC)
    when 'late'
      return all.order(event_date: :ASC)
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    end
  end



end
