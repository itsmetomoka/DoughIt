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
  has_many :lessons
  has_many :reservations

  validates :name, presence: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 300}
  validates :email, presence: true, format: {with: /\A\S+@\S+\.\S+\z/,message: 'が正しくありません'}
  


end