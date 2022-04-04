# frozen_string_literal: true
class EventsController < ApplicationController
  before_action :set_resource, only: [:show,:edit,:update,:destroy]

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true)
    @events = Event.page(params[:page]).per(5)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.user_events.build(user: current_user)
    if @event.save
      flash[:notice] = "イベントを新規作成しました"
      redirect_to controller: :events, action: :index
    else
      flash[:notice] = "イベントを新規作成できませんでした"
      redirect_to controller: :events, action: :new
    end
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "イベント情報を更新しました"
      redirect_to controller: :events, action: :index
    else
      flash[:notice] = "イベント情報を更新できませんでした"
      redirect_to controller: :events,action: :edit, id: @event.id
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = "イベント情報を削除しました"
    else
      flash[:notice] = "イベント情報を削除できませんでした"
    end
    redirect_to controller: :events,action: :index
  end

  def join_to_event
    event = Event.find(params[:id])
    user_event = event.user_events.build(user: current_user)
    user_event.save
    flash[:notice] = "参加しました"
    redirect_to controller: :events, action: :show
  end

  def cancel_to_event
    user_event = UserEvent.find_by(event: params[:id],user: current_user.id)
    user_event.destroy
    flash[:notice] = "キャンセルしました"
    redirect_to controller: :events, action: :index
  end

  def search
    if params[:title]
      @events = Event.where("title LIKE(?)", "%#{params[:title]}%")
    elsif params[:place]
      @events = Event.where("place LIKE(?)", "%#{params[:place]}%")
    elsif params[:start_date]
      @events = Event.where("start_date LIKE(?)", "%#{params[:start_date]}%")
    else
      @events = Event.where("end_date LIKE(?)", "%#{params[:end_date]}%")
    end
    respond_to do |format|
      format.json { render json: @events }
    end
  end

  private
    def event_params
      params.require(:event).permit(:title,:place,:description,:start_date,:end_date,:deadline_date,:image)
    end

    def set_resource
      @event = Event.find(params[:id])
    end

end