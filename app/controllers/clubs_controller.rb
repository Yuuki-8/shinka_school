# frozen_string_literal: true
class ClubsController < ApplicationController
  before_action :set_resource,only: [:show,:edit,:update,:destroy]

  def index
    @q = Club.ransack(params[:q])
    @clubs = @q.result(distinct: true)
  end

  def show
  end

  def new
    @club = Club.new
  end

  def edit
  end

  def create
    @club = Club.new(club_params)
    @club.user_clubs.build(user: current_user)
    if @club.save
      flash[:notice] = "サークルを新規作成しました"
      redirect_to controller: :clubs,action: :index
    else
      flash[:notice] = "サークルを新規作成できませんでした"
      redirect_to controller: :clubs,action: :new
    end
  end

  def update
    if @club.update(club_params)
      flash[:notice] = "サークル情報を更新しました"
      redirect_to controller: :clubs,action: :index
    else
      flash[:notice] = "サークル情報を更新できませんでした"
      redirect_to controller: :clubs,action: :edit,id: @club.id
    end
  end

  def destroy
    if @club.destroy
      flash[:notice] = "サークル情報を削除しました"
    else
      flash[:notice] = "サークル情報を削除できませんでした"
    end
    redirect_to controller: :clubs,action: :index
  end

  def join_to_club
    club = Club.find(params[:id])
    user_club = club.user_clubs.build(user: current_user)
    user_club.save
    flash[:notice] = "参加しました"
    redirect_to controller: :clubs, action: :show
  end

  def cancel_to_club
    user_club = UserClub.find_by(club: params[:id],user: current_user.id)
    user_club.destroy
    flash[:notice] = "キャンセルしました"
    redirect_to controller: :clubs, action: :index
  end

  def search
    @clubs = Club.where("name LIKE(?)", "%#{params[:name]}%")
    respond_to do |format|
      format.json { render json: @clubs }
    end
  end

  private
    def club_params
      params.require(:club).permit(:name,:description,:image)
    end

    def set_resource
      @club = Club.find(params[:id])
    end

end