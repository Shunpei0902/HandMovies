class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :movies, dependent: :destroy
  
  has_one_attached :profile_image
  #ユーザー名を設定しないとアカウント作成出来ない
  validates :username, presence: true

  has_many :comments, dependent: :destroy
end
