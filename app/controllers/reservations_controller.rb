class ReservationsController < ApplicationController

  def new
    @reservation = Reservation.new
    render plain: render_to_string(partial: 'form_new', layout: false, locals: { reservation: @reservation })
  end

  def index
    @events = Reservation.all
  end

  def create
    @reservation = Reservation.new(params_reservation)
    if @reservation.save
      respond_to do |format|
        format.html { redirect_to reservations_path }
        format.js #create.js.erbを探してその中の処理を実行する
      end
    else
      respond_to do |format|
        format.js { render partial: "error" }
        #登録にエラーが起きたときはerror.js.erbを実行する
      end
    end
  end

  def params_reservation
      params.require(:reservation).permit(:title, :start_date, :end_date)
  end
end