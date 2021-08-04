require 'rails_helper'

RSpec.describe Admin, type: :model do
  before do
    @admin = build(:admin)
    create(:attendance, admin: @admin)
  end

  describe 'バリデーション' do
    it '全ての値が正しく設定されていれば @admin.valid? が trueになること' do
      expect(@admin.valid?).to(eq(true))
    end

    describe "name" do
      it 'nameが空だと @admin.valid? が falseになること' do
        @admin.name = ''
        expect(@admin.valid?).to(eq(false))
      end
    end
  end

  describe 'アソシエーション' do
    it "紐づくattendanceが取得できていること" do
      expect(@admin.attendances.present?).to(eq(true))
    end
  end
end