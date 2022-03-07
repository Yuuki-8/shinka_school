# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservation, type: :model do
  before do
    user = create(:user)
    mentor = create(:mentor)
    @reservation = build(:reservation, user: user, mentor: mentor)
  end

  describe "バリデーション" do
    it "全ての値が正しく設定されていれば @reservation.valid? が trueになること" do
      expect(@reservation.valid?).to(eq(true))
    end

    describe "start_date" do
      it "start_dateが空だと @reservation.valid? が falseになること" do
        @reservation.start_date = ""
        expect(@reservation.valid?).to(eq(false))
      end
    end

    describe "start_end_check" do
      context "start_dateよりもend_dateの方が未来の時刻である場合" do
        it "@reservation.valid? はtrueになること" do
          @reservation.start_date = DateTime.now.since(3.months)
          @reservation.end_date = @reservation.start_date.since(2.hours)
          expect(@reservation.valid?).to(eq(true))
        end
      end
      context "start_dateよりもend_dateの方が過去の時刻である場合" do
        it "@reservation.valid? はfalseになること" do
          @reservation.start_date = DateTime.now.since(3.months)
          @reservation.end_date = @reservation.start_date.since(-2.hours)
          expect(@reservation.valid?).to(eq(false))
        end
      end
    end
    describe "start_check" do
      context "start_dateが現在時刻より7日以降の時刻である場合" do
        it "@reservation.valid? はtrueになること" do
          @reservation.start_date = Date.today.since(8.days)
          @reservation.end_date = @reservation.start_date.since(2.hours)
          expect(@reservation.valid?).to(eq(true))
        end
      end
      context "start_dateが現在時刻より7日以内の時刻である場合" do
        it "@reservation.valid? はfalseになること" do
          @reservation.start_date = Date.today.since(6.days)
          @reservation.end_date = @reservation.start_date.since(2.hours)
          expect(@reservation.valid?).to(eq(false))
        end
      end
    end
  end

  describe "アソシエーション" do
    it "紐づくuserが取得できていること" do
      expect(@reservation.user.present?).to(eq(true))
    end
    it "紐づくmentorが取得できていること" do
      expect(@reservation.mentor.present?).to(eq(true))
    end
  end
end
