# frozen_string_literal: true

require "rails_helper"

RSpec.describe Event, type: :model do
  before do
    user = create(:user)
    @event = build(:event)
    create(:user_event, user: user, event: @event)
  end

  describe "バリデーション" do
    it "全ての値が正しく設定されていれば @event.valid? が trueになること" do
      expect(@event.valid?).to(eq(true))
    end

    describe "title" do
      it "titleが空だと @event.valid? が falseになること" do
        @event.title = ""
        expect(@event.valid?).to(eq(false))
      end
    end

    describe "place" do
      it "placeが空だと @event.valid? が falseになること" do
        @event.place = ""
        expect(@event.valid?).to(eq(false))
      end
    end

    describe "start_date" do
      it "start_dateが空だと @event.valid? が falseになること" do
        @event.start_date = ""
        expect(@event.valid?).to(eq(false))
      end
    end

    describe "end_date" do
      it "end_dateが空だと @event.valid? が falseになること" do
        @event.end_date = ""
        expect(@event.valid?).to(eq(false))
      end
    end

    describe "deadline_date" do
      it "deadline_dateが空だと @event.valid? が falseになること" do
        @event.deadline_date = ""
        expect(@event.valid?).to(eq(false))
      end
    end

    describe "start_end_check" do
      context "start_dateよりもend_dateの方が未来の時刻である場合" do
        it "@event.valid? はtrueになること" do
          @event.start_date = "2021/8/1 10:00"
          @event.end_date = "2021/8/1 12:00"
          expect(@event.valid?).to(eq(true))
        end
      end
      context "start_dateよりもend_dateの方が過去の時刻である場合" do
        it "@event.valid? はfalseになること" do
          @event.start_date = "2021/8/1 12:00"
          @event.end_date = "2021/8/1 10:00"
          expect(@event.valid?).to(eq(false))
        end
      end
    end

    describe "deadline_start_check" do
      context "deadline_dateよりもstart_dateの方が未来の時刻である場合" do
        it "@event.valid? はtrueになること" do
          @event.deadline_date = "2021/8/1 10:00"
          @event.start_date = "2021/8/1 12:00"
          expect(@event.valid?).to(eq(true))
        end
      end
      context "deadline_dateよりもstart_dateの方が過去の時刻である場合" do
        it "@event.valid? はfalseになること" do
          @event.deadline_date = "2021/8/1 12:00"
          @event.start_date = "2021/8/1 10:00"
          expect(@event.valid?).to(eq(false))
        end
      end
    end
  end

  describe "アソシエーション" do
    it "紐づくuserが取得できていること" do
      expect(@event.users.present?).to(eq(true))
    end
  end
end
