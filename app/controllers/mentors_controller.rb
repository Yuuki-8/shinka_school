class MentorsController < ApplicationController
  before_action :set_resource, only: [:show]

  def index
    @q = Mentor.ransack(params[:q])
    @mentors = @q.result(distinct: true).order(id: :desc).page(params[:page]).per(5)
  end

  def show
  end

  def home
  end

  def profile
    @mentor = current_mentor
  end

  private

  def set_resource
    @mentor = Mentor.find(params[:id])
  end
end