class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find_by(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.user_events.build(user: current_user)
    if @event.save
      flash[:success] = "イベントを新規作成しました"
      redirect_to controller: :events, action: :index
    else
      redirect_to controller: :events, action: :new
    end
  end

  def update
    @event = Event.find_by(params[:id])
    if @event.update(event_params)
      flash[:success] = "イベントを更新しました"
      redirect_to controller: :events, action: :index
    else
      redirect_to controller: :events, action: :edit, id: @event.id
    end
  end

  def destroy
    @event = Event.find_by(params[:id])
    @event.delete
    redirect_to controller: :events, action: :index
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :title, :start_date, :end_date, :deadline_date, :place)
  end
end