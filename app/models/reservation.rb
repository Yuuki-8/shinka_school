class Reservation < ApplicationRecord
  before_save :set_status

  belongs_to :user, optional: true
  belongs_to :mentor, optional: true

  validate  :start_end_check
  validates :start_time, presence: true

  default_scope -> { order(start_date: :asc) }

  enum reservation_status: %i( before matched )

  #時間の矛盾を防ぐ
  def start_end_check
    if self.start_time.present? && self.end_time.present?
      errors.add(:end_time, "が勤務開始時刻を上回っています。正しく記入してください。") if self.start_time > self.end_time
    end
  end

  def set_status
    if self.user_id && self.mentor_id
      self.reservation_status = 1
    else
      self.reservation_status = 0
    end
  end
end
