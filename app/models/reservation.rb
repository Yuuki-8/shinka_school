class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :mentor, optional: true

  default_scope -> { order(start_date: :asc) }

  validate  :start_end_check

  enum reservation_status: { before: 1, matched: 2 }

  #時間の矛盾を防ぐ
  def start_end_check
    if self.start_date.present? && self.end_date.present?
      errors.add(:end_date, "が開始時刻を上回っています。正しく記入してください。") if self.start_date > self.end_date
    end
  end
end
