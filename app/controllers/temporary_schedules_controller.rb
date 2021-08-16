# frozen_string_literal: true

class TemporarySchedulesController < ApplicationController
  before_action :set_resource, only: [:show, :update, :destroy, :create_reservation]

  def index
    @events = TemporarySchedule.where(mentor: current_mentor)
  end

  def show
    render plain: render_to_string(partial: "form_temporary_schedule_edit", layout: false, locals: { temp_schedule: @temp_schedule })
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    if @temp_schedule.update(params_temp_schedule)
      respond_to do |format|
        format.html { redirect_to temporary_schedules_path }
        format.js { render "temporary_schedules/update.js.erb", layout: false }
      end
    else
      respond_to do |format|
        format.js { render "temporary_schedules/error.js.erb", layout: false }
      end
    end
  end

  def destroy
    if @temp_schedule.delete
      respond_to do |format|
        format.html { redirect_to temporary_schedules_path }
        format.js { render "temporary_schedules/destroy.js.erb", layout: false }
      end
    else
      respond_to do |format|
        format.js { render "temporary_schedules/error.js.erb", layout: false }
      end
    end
  end

  def schedule_of_mentor
    @mentor = Mentor.find(params[:id])
    @q = @mentor.temporary_schedules.ransack(params[:q])
    @temporary_schedules = @q.result(distinct: true).a_week_ago.order(id: :asc).page(params[:page]).per(20)
  end

  def create_reservation
    reservation = Reservation.new(mentor: @temp_schedule.mentor, user: current_user, start_date: @temp_schedule.start_time, end_date: @temp_schedule.end_time, reservation_status: 0, title: "メンタリング(#{current_user.name}_#{@temp_schedule.mentor.name})")
    if reservation.save
      flash[:notice] = "予約を受け付けました"
    else
      flash[:notice] = "予約を受け付けできませんでした"
    end
    redirect_to schedule_of_mentor_temporary_schedule_path(@temp_schedule.mentor)
  end

  def params_temp_schedule
    params.require(:temporary_schedule).permit(:id, :mentor_id, :start_time, :end_time)
  end

  private
    def set_resource
      @temp_schedule = TemporarySchedule.find(params[:id])
    end
end
