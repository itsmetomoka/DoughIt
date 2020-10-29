class Lesson < ApplicationRecord
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :reservations, dependent: :destroy
	belongs_to :user
	attr_accessor :image_cache
	mount_uploader :image, ImageUploader

	enum category_name: {洋食: 0, 和食: 1, パン: 2, ケーキ: 3}

  scope :only_active, -> { where(is_active: true) }

	with_options presence: true do
		validates :tuition
		validates :name, length: {maximum:100}
		validates :content #, length: {in: 20..200}
		validates :event_date
		validates :deadline
	end
	validate :deadline_check
	validate :date_not_before_today


	# 募集締め切りが開催日よりも前の日付か
	def deadline_check
    errors.add(:deadline, "の日付を正しく記入してください。") unless
    self.deadline < self.event_date
  end

# 開催日が当日以降であるか
  def date_not_before_today
  	errors.add(:event_date, "は今日以降に設定してください") unless
  	 DateTime.now < self.event_date
  end

# 募集締め切り日が当日以降であるか
  def date_not_before_today
  	errors.add(:deadline, "は今日以降に設定してください") unless
  	 DateTime.now < self.deadline
  end


  def start_time
  	self.event_date
  end

  def self.search(word)
  	@lesson = Lesson.where("name LIKE?","%#{word}%")
  end

  def self.search(category)
  	@lesson = Lesson.where("category_name LIKE?","#{category}")
  end

end
