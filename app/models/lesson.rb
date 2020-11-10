class Lesson < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :reservations, dependent: :destroy
	belongs_to :user
  has_many :notifications, dependent: :destroy


	attr_accessor :image_cache
	mount_uploader :image, ImageUploader

	enum category_name: {洋食: 0, 和食: 1, パン: 2, ケーキ: 3}

  scope :only_active, -> { where(is_active: true) }
  scope :not_active, -> { where(is_active: false) }

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

  def self.sort(sort, category)
    if category == 'western'
      lessons = Lesson.where(category_name: 0)
      if sort == 'early'
        sort_lesson = lessons.order(event_date: :DESC)
      elsif sort == 'late'
        sort_lesson = lessons.order(event_date: :ASC)
      elsif sort == 'new'
        sort_lesson = lessons.order(created_at: :DESC)
      elsif sort == 'old'
        sort_lesson = lessons.order(created_at: :ASC)
      end
    elsif category == 'japanese'
      lessons = Lesson.where(category_name: 1)
      if sort == 'early'
        sort_lesson = lessons.order(event_date: :DESC)
      elsif sort == 'late'
        sort_lesson = lessons.order(event_date: :ASC)
      elsif sort == 'new'
        sort_lesson = lessons.order(created_at: :DESC)
      elsif sort == 'old'
        sort_lesson = lessons.order(created_at: :ASC)
      end
    elsif category == 'bread'
      lessons = Lesson.where(category_name: 2)
      if sort == 'early'
        sort_lesson = lessons.order(event_date: :DESC)
      elsif sort == 'late'
        sort_lesson = lessons.order(event_date: :ASC)
      elsif sort == 'new'
        sort_lesson = lessons.order(created_at: :DESC)
      elsif sort == 'old'
        sort_lesson = lessons.order(created_at: :ASC)
      end
    elsif category == 'cake'
      lessons = Lesson.where(category_name: 3)
      if sort == 'early'
        sort_lesson = lessons.order(event_date: :DESC)
      elsif sort == 'late'
        sort_lesson = lessons.order(event_date: :ASC)
      elsif sort == 'new'
        sort_lesson = lessons.order(created_at: :DESC)
      elsif sort == 'old'
        sort_lesson = lessons.order(created_at: :ASC)
      end
    else
      if sort == 'early'
        all_lesson = all.order(event_date: :DESC)
      elsif sort == 'late'
        all_lesson = all.order(event_date: :ASC)
      elsif sort == 'new'
        all_lesson = all.order(created_at: :DESC)
      elsif sort == 'old'
        all_lesson = all.order(created_at: :ASC)
      end
    end
  end



end
