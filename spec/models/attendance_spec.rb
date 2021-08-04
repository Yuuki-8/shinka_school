require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before do
    admin = create(:admin)
    @attendance = create(:attendance, admin: admin)
  end

  describe 'バリデーション' do
    it '全ての値が正しく設定されていれば @attendance.valid? が trueになること' do
      expect(@attendance.valid?).to(eq(true))
    end

    describe "start_end_check" do
      context "start_timeよりもend_timeの方が未来の時刻である場合" do
        it '@attendance.valid? はtrueになること' do
          @attendance.start_time = '2021/8/1 10:00'
          @attendance.end_time = '2021/8/1 12:00'
          expect(@attendance.valid?).to(eq(true))
        end
      end
      context "start_timeよりもend_timeの方が過去の時刻である場合" do
        it '@attendance.valid? はfalseになること' do
          @attendance.start_time = '2021/8/1 12:00'
          @attendance.end_time = '2021/8/1 10:00'
          expect(@attendance.valid?).to(eq(false))
        end
      end
    end
  end

  describe 'アソシエーション' do
    it "紐づくadminが取得できていること" do
      expect(@attendance.admin.present?).to(eq(true))
    end
  end
end