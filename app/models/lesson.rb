class Lesson < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :reservations, dependent: :destroy
	belongs_to :user
	attr_accessor :image_cache
	mount_uploader :image, ImageUploader

	enum category_name: {洋食: 0, 和食: 1, パン: 2, ケーキ: 3}

  scope :only_active, -> { where(is_active: true) }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?


	with_options presence: true do
		validates :tuition
		validates :name, length: {maximum:100}
		validates :content #, length: {in: 20..200}
		validates :event_date
		validates :deadline
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



end
