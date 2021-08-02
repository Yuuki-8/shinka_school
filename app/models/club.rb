class Club < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :user_clubs
  has_many :users, through: :user_clubs
end
