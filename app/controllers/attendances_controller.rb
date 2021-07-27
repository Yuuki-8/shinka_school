class AttendancesController < ApplicationController
  def index
    @attendance = current_admin.attendances.today_attendance_scope.first
    @attendances = []
    @attendances = current_admin.attendances.week_attendances_scope.map do |attendance|
      [attendance.start_time.strftime('%Y/%m/%d'), attendance.working_time]
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @attendance = current_admin.attendances.build(start_time: Time.zone.now)
    Attendance.transaction do
      @attendance.save!
      render action: :index
    end
  end

  def update
    @attendance = current_admin.attendances.today_attendance_scope
    Attendance.transaction do
      @attendance.update!(end_time: Time.zone.now)
      render action: :index
    end
  end

  def destroy
  end
end