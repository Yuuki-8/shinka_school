# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserClub, type: :model do
  before do
    user = create(:user)
    club = create(:club)
    @user_club = create(:user_club, user: user, club: club)
  end

  describe "アソシエーション" do
    it "紐づくuserが取得できていること" do
      expect(@user_club.user.present?).to(eq(true))
    end
    it "紐づくclubが取得できていること" do
      expect(@user_club.club.present?).to(eq(true))
    end
  end
end
