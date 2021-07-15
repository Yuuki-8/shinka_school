class ReservationsController < ApplicationController

  def new
    @reservation = Reservation.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { reservation: @reservation })
  end

  def index
    @events = nil
    if current_user?
      @events = Reservation.where(user_id: current_user.id)
    else
      @events = Reservation.where(mentor_id: current_mentor.id)
    end
  end

  def create
    @reservation = current_user? ? Reservation.new(params_reservation.merge({ 'user_id': current_user.id })) : Reservation.new(params_reservation.merge({ 'mentor_id': current_mentor.id }))
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

  def params_reservation
      params.require(:reservation).permit(:title, :reservation_status, :start_date, :end_date)
  end
end