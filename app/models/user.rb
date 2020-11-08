class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 論理削除
  acts_as_paranoid
  # carrierwave
  mount_uploader :image, ImageUploader
  # アソシエーション
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_lessons, through: :favorites,source: :lesson
  has_many :lessons
  has_many :reservations
  has_many :reviews, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  validates :name, presence: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 300}
  validates :email, presence: true, format: {with: /\A\S+@\S+\.\S+\z/,message: 'が正しくありません'}, uniqueness: true



  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'read-only-user'
    end
  end


end