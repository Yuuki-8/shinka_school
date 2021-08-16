class MentorScheduleSetting < ApplicationRecord
  belongs_to :mentor_setting

  validate :start_end_check
  validates :weekday_code, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  enum weekday_code: %i( sun mon tue wed thu fri sat )

  #時間の矛盾を防ぐ
  def start_end_check
    if self.start_time.present? && self.end_time.present?
      errors.add(:end_time, "が開始時刻を上回っています。正しく記入してください。") if self.start_time > self.end_time
    end
  end
end
