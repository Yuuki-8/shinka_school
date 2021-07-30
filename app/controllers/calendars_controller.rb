class CalendarsController < ApplicationController

  def new
    @reservation = Reservation.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { reservation: @reservation })
  end

  def show
    @reservation = nil
    if params[:class_name] == "Reservation"
      @reservation = Reservation.find(params[:id])
      render plain: render_to_string(partial: 'form_reservation_edit', layout: false, locals: { reservation: @reservation })
    else
      @reservation = Event.find(params[:id])
      render plain: render_to_string(partial: 'form_event_edit', layout: false, locals: { event: @reservation })
    end
  end

  def index
    @events = nil
    if current_user?
      @events = Reservation.where(user_id: current_user.id).to_a + current_user.events.to_a
    elsif current_mentor?
      @events = Reservation.where(mentor_id: current_mentor.id)
    elsif current_admin?
      @events = Reservation.where(admin_id: current_admin.id)
    end
  end

  def create
    @reservation = Reservation.new(params_reservation)
    if @reservation.save
      respond_to do |format|
        format.html { redirect_to reservations_path }
        format.js { render 'reservations/create.js.erb', layout: false}
      end
    else
      respond_to do |format|
        format.js { render 'reservations/error.js.erb', layout: false }
      end
    end
  end

  def update
    update_params = nil
    @object = nil
    if params[:reservation].present?
      @object = Reservation.find(params[:id])
      update_params = params_reservation
    else
      @object = Event.find(params[:id])
      update_params = params_event
    end

    if @object.update(update_params)
      respond_to do |format|
        format.html { redirect_to reservations_path }
        format.js { render 'reservations/update.js.erb', layout: false}
      end
    else
      respond_to do |format|
        format.js { render 'reservations/error.js.erb', layout: false }
      end
    end
  end

  def params_reservation
      params.require(:reservation).permit(:id, :user_id, :mentor_id, :title, :reservation_status, :start_date, :end_date)
  end

  def params_event
      params.require(:event).permit(:id, :title, :place, :reservation_status, :start_date, :end_date)
  end
end