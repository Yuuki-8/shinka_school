# frozen_string_literal: true

class MentorSettingsController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @mentor_setting = current_mentor.mentor_setting
    @schedule_settings = @mentor_setting&.mentor_schedule_settings
  end

  def show
  end

  def new
    @mentor_setting = MentorSetting.new(mentor: current_mentor)
    @mentor_schedule_setting = @mentor_setting.mentor_schedule_settings.build
  end

  def edit
    @mentor_schedule_setting = @mentor_setting.mentor_schedule_settings
  end

  def create
    if @mentor_setting.save
      flash[:notice] = "メンタリング可能時刻を設定しました"
      redirect_to controller: :mentor_settings, action: :index
    else
      flash[:notice] = "メンタリング可能時刻を設定できませんでした"
      redirect_to controller: :mentor_settings, action: :new
    end
  end

  def update
    if @mentor_setting.update(setting_params)
      flash[:notice] = "メンタリング可能時刻を更新しました"
      redirect_to controller: :mentor_settings, action: :index
    else
      flash[:notice] = "メンタリング可能時刻を更新できませんでした"
      redirect_to controller: :mentor_settings, action: :edit
    end
  end

  def destroy
    @mentor_setting.destroy
    flash[:notice] = "メンタリング可能時刻を削除しました"
    redirect_to controller: :mentor_settings, action: :index
  end

  private
    def set_resource
      @mentor_setting = MentorSetting.find(params[:id])
    end

    def setting_params
      params.require(:mentor_setting).permit(:mentor_id, mentor_schedule_settings_attributes: [:id, :weekday_code, :start_time, :end_time, :_destroy])
    end
end
