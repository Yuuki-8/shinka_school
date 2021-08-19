# frozen_string_literal: true

class AttendancesController < ApplicationController
  def index
    @attendance = current_admin.attendances.where(start_time: Time.zone.today).first
  end

  def show
    @attendances = []
    days = ["日", "月", "火", "水", "木", "金", "土"]
    @attendances = current_admin.attendances.week_attendances_scope.sort { |a, b| a.id <=> b.id }.map do |attendance|
      working_day = attendance.start_time.strftime("%Y/%m/%d") + "(#{days[attendance.start_time.to_date.wday]})"
      [working_day, attendance.working_time]
    end
  end

  def new
  end

  def edit
  end

  def create
    @attendance = current_admin.attendances.build(start_time: Time.zone.now)
    Attendance.transaction do
      @attendance.save!
      flash[:notice] = "出勤を確認しました！"
      redirect_to attendances_path
    end
  end

  def update
    @attendance = current_admin.attendances.today_attendance_scope.first
    Attendance.transaction do
      @attendance.update!(end_time: Time.zone.now)
      flash[:notice] = "退勤を確認しました！お疲れ様でした"
      redirect_to attendances_path
    end
  end

  def destroy
  end
end
