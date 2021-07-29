class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events

  default_scope -> { order(start_date: :asc) }

  validate  :start_end_check

  #時間の矛盾を防ぐ
  def start_end_check
    if self.start_date.present? && self.end_date.present?
      errors.add(:end_date, "が開始時刻を上回っています。正しく記入してください。") if self.start_date > self.end_date
    end
  end
end
