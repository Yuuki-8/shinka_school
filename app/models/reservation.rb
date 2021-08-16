class Reservation < ApplicationRecord
  # before_save :set_status

  belongs_to :user, optional: true
  belongs_to :mentor, optional: true

  validate  :start_check
  validate  :start_end_check
  validates :title, presence: true
  validates :start_date, presence: true

  default_scope -> { order(start_date: :asc) }

  enum reservation_status: %i( before matched )

  #時間の矛盾を防ぐ
  def start_end_check
    if self.start_date.present? && self.end_date.present?
      errors.add(:end_date, "が勤務開始時刻を上回っています。正しく記入してください。") if self.start_date > self.end_date
    end
  end

  def start_check
    errors.add(:start_date, "予約時刻は本日より1週間以上先の日付を選択してください") if self.start_date.present? && self.start_date <= Date.today.since(7.days)
  end

  def set_status
    if self.user_id && self.mentor_id
      self.reservation_status = 1
    else
      self.reservation_status = 0
    end
  end

  def to_ja_wday
    wday = { '0': '日', '1': '月', '2': '火', '3': '水', '4': '木', '5': '金', '6': '土' }
    wday[:"#{self.start_date.wday.to_s}"]
  end
end
