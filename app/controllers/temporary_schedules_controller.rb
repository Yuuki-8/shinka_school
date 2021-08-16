class TemporarySchedulesController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def schedule_of_mentor
    @mentor = Mentor.find(params[:id])
    @q = @mentor.temporary_schedules.ransack(params[:q])
    @temporary_schedules = @q.result(distinct: true).a_week_ago.order(id: :asc).page(params[:page]).per(20)
  end

  def create_reservation
    temp_schedule = TemporarySchedule.find(params[:id])
    reservation = Reservation.new(mentor: temp_schedule.mentor, user: current_user, start_date: temp_schedule.start_time, end_date: temp_schedule.end_time, reservation_status: 0, title: "メンタリング(#{current_user.name}_#{temp_schedule.mentor.name})")
    if reservation.save
      flash[:notice] = "予約を受け付けました"
    else
      flash[:notice] = "予約を受け付けできませんでした"
    end
    redirect_to schedule_of_mentor_temporary_schedule_path(temp_schedule.mentor)
  end
end