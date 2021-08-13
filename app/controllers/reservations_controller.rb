class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.where(mentor: current_mentor, reservation_status: 0)
  end

  def accept_reservation
    reservation = Reservation.find(params[:id])
    reservation.reservation_status = 1
    if reservation.save
      flash[:notice] = "メンタリング日時が確定しました。カレンダーでご確認ください"
    else
      flash[:notice] = "エラーが発生しました。"
    end
    redirect_to reservations_path
  end
end