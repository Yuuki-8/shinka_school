# frozen_string_literal: true
class ClubsController < ApplicationController
  before_action :set_resource,only: [:show,:edit,:update,:destroy]

  def index
    @clubs = Club.all
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

  private
    def club_params
      params.require(:club).permit(:name,:description,:image)
    end

    def set_resource
      @club = Club.find(params[:id])
    end

end