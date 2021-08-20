# frozen_string_literal: true

class MentorsController < ApplicationController
  before_action :set_resource, only: [:show]

  def index
    @mentors = Mentor.all
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
