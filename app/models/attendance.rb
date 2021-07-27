class Attendance < ApplicationRecord
  before_update :set_working_time

  belongs_to :admin, optional: true

  scope :today_attendance_scope, -> { where(start_time: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day) }
  scope :week_attendances_scope, -> { where(start_time: Time.zone.today.ago(7.days).beginning_of_day..Time.zone.today.end_of_day).where.not(start_time: nil, end_time: nil).order(start_time: :asc) }

  def set_working_time
    self.working_time = ((self.end_time - self.start_time).floor / 3600).floor(1)
  end
end
