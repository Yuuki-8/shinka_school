# frozen_string_literal: true

class Club < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }

  mount_uploader :image, ImageUploader

  has_many :user_clubs
  has_many :users, through: :user_clubs

  validates :name, presence: true
  validates :description, presence: true
end
