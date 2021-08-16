# frozen_string_literal: true

class UsersController < ApplicationController
  def index
  end

  def home
  end

  def profile
    @user = current_user
  end
end
