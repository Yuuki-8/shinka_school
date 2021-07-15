class UsersController < ApplicationController
  def index
  end

  def profile
    @user = current_user
  end
end