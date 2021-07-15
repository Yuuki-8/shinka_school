class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :mentor, optional: true

  default_scope -> { order(start_date: :asc) }

  validate  :start_end_check

  before_save :set_status

  enum reservation_status: %i( before matched )

  #時間の矛盾を防ぐ
  def start_end_check
    if self.start_date.present? && self.end_date.present?
      errors.add(:end_date, "が開始時刻を上回っています。正しく記入してください。") if self.start_date > self.end_date
    end
  end

  def set_status
    if self.user_id
      self.reservation_status = 1
    else
      self.reservation_status = 0
    end
  end
end
