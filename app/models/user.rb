require "validators/email_format_validator"
require "validators/name_kana_validator"
require "validators/phone_no_validator"
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

  validates :name, presence: true, length: { maximum: 100 }
  validates :name_kana, presence: true, format: { with: NameKanaValidator::CODE_REGEX, multiline: true }, length: { maximum: 100 }
  validates :phone, presence: true, format: { with: PhoneNoValidator::CODE_REGEX, multiline: true }, length: { maximum: 15 }
  validates :email, format: { with: EmailFormatValidator::CODE_REGEX }, allow_blank: true

  enum gender: %i( male female )
end
