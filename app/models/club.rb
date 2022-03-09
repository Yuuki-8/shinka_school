# frozen_string_literal: true

class Club < ApplicationRecord
  mount_uploader :image,ImageUploader
  has_many :user_clubs,dependent: :destroy
  has_many :users,through: :user_clubs
  validates :name,presence:true
  validates :description,presence:true
end