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

  # 並び替え
  def self.sort(sort, category, date, user_id)
    if sort == 'early'
      lessons = Lesson.order(event_date: :DESC)
    elsif sort == 'late'
      lessons = Lesson.order(event_date: :ASC)
    elsif sort == 'new'
      lessons = Lesson.order(created_at: :DESC)
    elsif sort == 'old'
      lessons = Lesson.order(created_at: :ASC)
    end

  # ジャンル絞り込み
    if category == 'western'
      sort_lesson = lessons.where(category_name: 0)
    elsif category == 'japanese'
      sort_lesson = lessons.where(category_name: 1)
    elsif category == 'bread'
      sort_lesson = lessons.where(category_name: 2)
    elsif category == 'cake'
      sort_lesson = lessons.where(category_name: 3)
    else
      sort_lesson = lessons
    end

  # 日付とユーザーで絞り込み
    if date.empty? && user_id.empty?
      all_lesson = sort_lesson
    elsif date.empty? && user_id.present?
      all_lesson = sort_lesson.where(user_id: user_id)
    elsif date.present? && user_id.empty?
      all_lesson = sort_lesson.where(event_date: date.in_time_zone.all_day)
    else
      all_lesson = sort_lesson.where(event_date: date.in_time_zone.all_day, user_id: user_id)
    end

  end

end
