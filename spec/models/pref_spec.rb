# frozen_string_literal: true

require "rails_helper"

RSpec.describe Pref, type: :model do
  before do
    @pref = build(:pref)
    create(:user, pref: @pref)
    create(:mentor, pref: @pref)
  end

  describe "バリデーション" do
    it "全ての値が正しく設定されていれば @pref.valid? が trueになること" do
      expect(@pref.valid?).to(eq(true))
    end

    describe "name" do
      it "nameが空だと @pref.valid? が falseになること" do
        @pref.name = ""
        expect(@pref.valid?).to(eq(false))
      end
    end
  end

  describe "アソシエーション" do
    it "紐づくuserが取得できていること" do
      expect(@pref.users.present?).to(eq(true))
    end
    it "紐づくmentorが取得できていること" do
      expect(@pref.mentors.present?).to(eq(true))
    end
  end
end
