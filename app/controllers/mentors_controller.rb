class MentorsController < ApplicationController
  def index
  end

  def profile
    @mentor = current_mentor
  end
end