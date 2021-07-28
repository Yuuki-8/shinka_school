class Mentor < ApplicationRecord
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :job, optional: true
  belongs_to :pref, optional: true
  has_many :reservations
  has_many :users, through: :reservations

  enum gender: %i( male female )
end
