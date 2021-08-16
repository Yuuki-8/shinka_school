# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserEvent, type: :model do
  before do
    user = create(:user)
    event = create(:event)
    @user_event = create(:user_event, user: user, event: event)
  end

  describe "アソシエーション" do
    it "紐づくuserが取得できていること" do
      expect(@user_event.user.present?).to(eq(true))
    end
    it "紐づくeventが取得できていること" do
      expect(@user_event.event.present?).to(eq(true))
    end
  end
end
