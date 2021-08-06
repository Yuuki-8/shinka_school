class EventsController < ApplicationController
  def index
    @q = Event.ransack(params[:q])
    @events = @q.result(distinct: true).order(id: :desc).page(params[:page]).per(5)
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
      flash[:notice] = "イベントを新規作成できませんでした"
      redirect_to controller: :events, action: :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "イベント情報を更新しました"
      redirect_to controller: :events, action: :show
    else
      flash[:notice] = "イベント情報を更新できませんでした"
      redirect_to controller: :events, action: :edit, id: @event.id
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.discard
      flash[:notice] = "イベントを削除しました"
    else
      flash[:notice] = "イベントを削除できませんでした"
    end
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
    params.require(:event).permit(:title, :description, :start_date, :end_date, :deadline_date, :place)
  end
end