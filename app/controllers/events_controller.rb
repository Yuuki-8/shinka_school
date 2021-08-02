class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    @event.user_events.build(user: current_user)
    if @event.save
      flash[:notice] = "イベントを新規作成しました"
      redirect_to controller: :events, action: :index
    else
      redirect_to controller: :events, action: :new
    end
  end

  def update
    @event = Event.find_by(params[:id])
    if @event.update(event_params)
      flash[:notice] = "イベントを更新しました"
      redirect_to controller: :events, action: :index
    else
      redirect_to controller: :events, action: :edit, id: @event.id
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.delete
    redirect_to controller: :events, action: :index
  end

  def join_to_event
    event = Event.find(params[:id])
    user_event = event.user_events.build(user: current_user)
    user_event.save
    redirect_to controller: :events, action: :show
  end

  def undo_from_event
    user_event = UserEvent.find_by!(event_id: params[:id], user: current_user)
    user_event.delete
    redirect_to controller: :events, action: :show
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :title, :start_date, :end_date, :deadline_date, :place)
  end
end