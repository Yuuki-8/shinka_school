class ClubsController < ApplicationController
  def index
    @q = Club.ransack(params[:q])
    @clubs = @q.result(distinct: true).order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @club = Club.find(params[:id])
  end

  def new
    @club = Club.new
  end

  def edit
    @club = Club.find(params[:id])
  end

  def create
    @club = Club.new(club_params)
    @club.user_clubs.build(user: current_user)
    if @club.save
      flash[:notice] = "サークルを新規作成しました"
      redirect_to controller: :clubs, action: :index
    else
      flash[:notice] = "サークルを新規作成できませんでした"
      redirect_to controller: :clubs, action: :new
    end
  end

  def update
    @club = Club.find_by(params[:id])
    if @club.update(club_params)
      flash[:notice] = "サークル情報を更新しました"
      redirect_to controller: :clubs, action: :index
    else
      flash[:notice] = "サークル情報を更新できませんでした"
      redirect_to controller: :clubs, action: :edit, id: @club.id
    end
  end

  def destroy
    @club = Club.find(params[:id])
    if @club.discard
      flash[:notice] = "サークル情報を削除しました"
    else
      flash[:notice] = "サークル情報を削除できませんでした"
    end
    redirect_to controller: :clubs, action: :index
  end

  def join_to_club
    club = Club.find(params[:id])
    user_club = club.user_clubs.build(user: current_user)
    user_club.save
    redirect_to controller: :clubs, action: :show
  end

  def undo_from_club
    user_club = UserClub.find_by!(club_id: params[:id], user: current_user)
    user_club.delete
    redirect_to controller: :clubs, action: :show
  end

  private

  def club_params
    params.require(:club).permit(:name, :description, :image)
  end
end