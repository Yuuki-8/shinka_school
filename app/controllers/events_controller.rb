# frozen_string_literal: true
class EventsController < ApplicationController
  before_action :set_resource, only: [:show,:edit,:update,:destroy]

  def index
    @events = Event.all
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
    redirect_to controller: :events, action: :show
  end

  def cancel_to_event
    user_event = UserEvent.find_by(event: params[:id],user: current_user.id)
    user_event.destroy
    redirect_to controller: :events, action: :index
  end

  private
    def event_params
      params.require(:event).permit(:title,:place, :description, :image)
    end

    def set_resource
      @event = Event.find(params[:id])
    end

end