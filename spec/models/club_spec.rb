# frozen_string_literal: true



require "rails_helper"

RSpec.describe Club, type: :model do
  before do
    user = create(:user)
    @club = create(:club)
    create(:user_club, user: user, club: @club)
  end



  describe "バリデーション" do

    it "全ての値が正しく設定されていれば @club.valid? が trueになること" do
      expect(@club.valid?).to(eq(true))
    end



    describe "name" do
      it "nameが空だと @club.valid? が falseになること" do
        @club.name = ""
        expect(@club.valid?).to(eq(false))
      end
    end



    describe "description" do
      it "descriptionが空だと @club.valid? が falseになること" do
        @club.description = ""
        expect(@club.valid?).to(eq(false))
      end
    end

  end

  describe "アソシエーション" do
    it "紐づくuserが取得できていること" do
      expect(@club.users.present?).to(eq(true))
    end
  end

end