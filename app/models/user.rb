class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 論理削除
  acts_as_paranoid

  attachment :profile_image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reservations
end
