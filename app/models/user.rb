class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :job, optional: true
  belongs_to :pref, optional: true
  has_many :reservations
  has_many :mentors, through: :reservations
  has_many :user_events
  has_many :events, through: :user_events
  has_many :user_clubs
  has_many :clubs, through: :user_clubs

  validates :name, presence: true
  validates :name_kana, presence: true

  enum gender: %i( male female )
end
