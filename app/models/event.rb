# frozen_string_literal: true

class Event < ApplicationRecord



  mount_uploader :image, ImageUploader

  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  validates :title, presence: true
  validates :place, presence: true
  validates :description, presence: true

end
